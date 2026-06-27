import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Represents a user's location with coordinates and optional city name.
class UserLocation {
  const UserLocation({
    required this.latitude,
    required this.longitude,
    this.cityName,
    this.countryCode,
    this.isFallback = false,
  });

  final double latitude;
  final double longitude;
  final String? cityName;
  final String? countryCode; // ISO 3166-1 alpha-2, e.g. 'JO', 'US'
  final bool isFallback; // true when GPS/permission unavailable (Makkah default)

  /// Makkah fallback coordinates (used when location is unavailable).
  static const fallback = UserLocation(
    latitude: 21.4225,
    longitude: 39.8262,
    cityName: 'Makkah',
    countryCode: 'SA',
    isFallback: true,
  );
}

/// Service that determines the user's location for prayer time calculations.
///
/// Strategy:
/// 1. Try to get fresh GPS coordinates (with a short timeout).
/// 2. If that fails (permission denied, timeout, etc.), use cached coordinates.
/// 3. If no cache exists, fall back to Makkah.
///
/// After a successful GPS read, the coordinates and reverse-geocoded city
/// name are persisted to SharedPreferences so subsequent app opens don't
/// need GPS.
class LocationService {
  static const _latKey = 'location_lat';
  static const _lngKey = 'location_lng';
  static const _cityKey = 'location_city';
  static const _countryKey = 'location_country';

  /// Guards against concurrent GPS/permission requests.
  /// If a request is already in-flight, subsequent callers share the same result.
  Completer<UserLocation>? _inFlightRequest;

  /// Get the user's current location, falling back gracefully.
  ///
  /// This method never throws. It always returns a [UserLocation].
  /// Concurrent calls are coalesced — only one GPS request runs at a time.
  Future<UserLocation> getCurrentLocation() async {
    // If a request is already in progress, wait for it instead of starting another.
    if (_inFlightRequest != null) {
      return _inFlightRequest!.future;
    }

    _inFlightRequest = Completer<UserLocation>();

    try {
      final result = await _fetchLocation();
      _inFlightRequest!.complete(result);
      return result;
    } catch (e) {
      final fallback = UserLocation.fallback;
      _inFlightRequest!.complete(fallback);
      return fallback;
    } finally {
      _inFlightRequest = null;
    }
  }

  /// Internal method that does the actual location fetching.
  Future<UserLocation> _fetchLocation() async {
    try {
      final position = await _getGpsPosition();
      if (position != null) {
        final place =
            await _reverseGeocode(position.latitude, position.longitude);
        final location = UserLocation(
          latitude: position.latitude,
          longitude: position.longitude,
          cityName: place.city,
          countryCode: place.countryCode,
        );
        await _cacheLocation(location);
        return location;
      }
    } catch (e) {
      debugPrint('LocationService GPS error: $e');
    }

    // Try cached location
    final cached = await getCachedLocation();
    if (cached != null) {
      debugPrint('LocationService: using cached location (${cached.cityName})');
      return cached;
    }

    // Ultimate fallback
    debugPrint('LocationService: using Makkah fallback');
    return UserLocation.fallback;
  }

  /// Attempt to get a GPS position. Returns null if permission is denied
  /// or location services are unavailable.
  Future<Position?> _getGpsPosition() async {
    // Check if location services are enabled
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint('LocationService: location services disabled');
      return null;
    }

    // Check / request permission
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint('LocationService: permission denied');
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint('LocationService: permission permanently denied');
      return null;
    }

    // Get position with a reasonable timeout so we don't block the app
    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.low, // We only need city-level precision
        timeLimit: Duration(seconds: 10),
      ),
    );
  }

  /// Reverse geocode coordinates to a city name + ISO country code.
  /// Returns nulls on failure (never throws).
  Future<({String? city, String? countryCode})> _reverseGeocode(
      double lat, double lng) async {
    try {
      final placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final city = place.locality ??
            place.subAdministrativeArea ??
            place.administrativeArea;
        return (city: city, countryCode: place.isoCountryCode);
      }
    } catch (e) {
      debugPrint('LocationService reverse geocode error: $e');
    }
    return (city: null, countryCode: null);
  }

  /// Retrieve the last cached location from SharedPreferences.
  Future<UserLocation?> getCachedLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final lat = prefs.getDouble(_latKey);
    final lng = prefs.getDouble(_lngKey);
    if (lat == null || lng == null) return null;

    return UserLocation(
      latitude: lat,
      longitude: lng,
      cityName: prefs.getString(_cityKey),
      countryCode: prefs.getString(_countryKey),
    );
  }

  /// Persist location to SharedPreferences.
  Future<void> _cacheLocation(UserLocation location) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_latKey, location.latitude);
    await prefs.setDouble(_lngKey, location.longitude);
    if (location.cityName != null) {
      await prefs.setString(_cityKey, location.cityName!);
    }
    if (location.countryCode != null) {
      await prefs.setString(_countryKey, location.countryCode!);
    }
  }
}
