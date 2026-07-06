import 'package:flutter/material.dart';

/// Niyyah palette.
///
/// Light = "Calm Minimal": soft off-white, sage green, deep forest, airy.
/// Dark  = "Premium Night": midnight green + warm gold, cream text.
abstract final class AppColors {
  // ── Sage/green family (brand) ────────────────────────────────────────────
  static const Color olive = Color(0xFF4F6048);        // Primary sage
  static const Color oliveDark = Color(0xFF2F4733);    // Deep forest
  static const Color oliveLight = Color(0xFFA7B49A);   // Light sage
  static const Color oliveVeryLight = Color(0xFFF1F3EC); // Soft sage tint
  static const Color beige = Color(0xFFC2A86B);        // Warm gold accent

  // ── Light theme — Calm Minimal ───────────────────────────────────────────
  static const Color primaryLight = Color(0xFF4F6048);       // Sage green
  static const Color primaryVariantLight = Color(0xFF2F4733); // Deep forest
  static const Color backgroundLight = Color(0xFFFBFBF9);    // Soft off-white
  static const Color surfaceLight = Color(0xFFFFFFFF);        // White cards
  static const Color surfaceVariantLight = Color(0xFFF1F3EC); // Soft sage surface
  static const Color onBackgroundLight = Color(0xFF2A2E28);   // Primary text
  static const Color onSurfaceLight = Color(0xFF2A2E28);      // Primary text
  static const Color onSurfaceVariantLight = Color(0xFF6E7468); // Secondary text
  static const Color dividerLight = Color(0xFFEAEDE3);        // Hairline divider

  // ── Dark theme — Premium Night ───────────────────────────────────────────
  static const Color primaryDark = Color(0xFFD8B878);         // Warm gold
  static const Color primaryVariantDark = Color(0xFFCAA45F);  // Deeper gold
  static const Color backgroundDark = Color(0xFF0C2019);      // Midnight green
  static const Color surfaceDark = Color(0xFF10271E);          // Card green
  static const Color surfaceVariantDark = Color(0xFF163326);   // Elevated green
  static const Color onBackgroundDark = Color(0xFFECE6D6);    // Cream text
  static const Color onSurfaceDark = Color(0xFFECE6D6);       // Cream text
  static const Color onSurfaceVariantDark = Color(0xFFB3AA92); // Muted cream
  static const Color dividerDark = Color(0xFF20402F);         // Subtle divider

  // ── Semantic colors ──────────────────────────────────────────────────────
  static const Color success = Color(0xFF4F6048);  // Sage (on-brand)
  static const Color warning = Color(0xFFC2A86B);  // Warm gold for gentle warnings
  static const Color error = Color(0xFFC66B6B);    // Soft red (not harsh)
  static const Color info = Color(0xFF4F6048);     // Sage

  // ── Gate / reading screen ────────────────────────────────────────────────
  static const Color gateBackgroundLight = Color(0xFFFBFBF9); // Calm off-white
  static const Color gateBackgroundDark = Color(0xFF0C2019);   // Midnight green
  static const Color arabicTextLight = Color(0xFF2A2E28);
  static const Color arabicTextDark = Color(0xFFF0EAD8);       // Warm cream
  static const Color translationTextLight = Color(0xFF6E7468);
  static const Color translationTextDark = Color(0xFFB3AA92);
  static const Color timerAccent = Color(0xFF7C8A6E);          // Mid sage (works both modes)

  // ── Gold accent ──────────────────────────────────────────────────────────
  static const Color gold = Color(0xFFC2A86B);
  static const Color goldLight = Color(0xFFD8B878);
}
