import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/providers.dart';
import '../../../core/quran/basmala.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/streak_logic.dart';
import '../../../l10n/app_strings.dart';
import '../../../data/datasources/quran/quran_database.dart';
import '../../../data/models/gate_content_type.dart';
import '../../../services/prayer_times_service.dart';
import '../../../shared/widgets/islamic_patterns.dart';
import '../../../shared/widgets/manuscript_decorations.dart';
import '../widgets/gate_timer.dart';

enum GateState { loading, reading, timerComplete, continuing, error }

/// A single piece of content in the continuous reading flow.
class _ContentBlock {
  _ContentBlock({
    required this.type,
    required this.title,
    required this.subtitle,
    this.ayahs,
    this.translations,
    this.duaArabic,
    this.duaTranslation,
    this.duaSource,
    this.duaId,
    this.surahNumber,
    this.ayahStart,
    this.ayahEnd,
    this.hadithArabic,
    this.hadithTranslation,
    this.hadithSource,
    this.hadithId,
  });

  final GateContentType type;
  final String title;
  final String subtitle;

  // Quran content
  final List<QuranAyah>? ayahs;
  final Map<int, String>? translations; // ayah.id -> translation text
  final int? surahNumber;
  final int? ayahStart;
  final int? ayahEnd;

  // Dua content
  final String? duaArabic;
  final String? duaTranslation;
  final String? duaSource;
  final int? duaId;

  // Hadith content
  final String? hadithArabic;
  final String? hadithTranslation;
  final String? hadithSource;
  final int? hadithId;
}

class GateScreen extends ConsumerStatefulWidget {
  const GateScreen({
    this.blockedAppId,
    this.blockedAppName,
    this.initialContentType,
    super.key,
  });

  final int? blockedAppId;
  final String? blockedAppName;
  /// If set, only load this content type (e.g. 'quran', 'dua', 'prophet_story')
  final String? initialContentType;

  @override
  ConsumerState<GateScreen> createState() => _GateScreenState();
}

class _GateScreenState extends ConsumerState<GateScreen> {
  GateState _gateState = GateState.loading;
  int _timerSeconds = 300;
  int _elapsedSeconds = 0;
  int _extraReadingSeconds = 0;
  Timer? _timer;
  Timer? _extraTimer;
  int? _gateSessionId;
  bool _progressRecorded = false;

  // Settings
  bool _showTranslation = true;
  double _fontSize = 28;
  String _translationLanguage = 'en';
  List<GateContentType> _enabledCategories = [GateContentType.quran];

  // Continuous content stream
  final List<_ContentBlock> _contentBlocks = [];
  bool _isLoadingMore = false;

  // Sequential position tracking
  int _currentSeqSurah = 1;
  int _currentSeqAyah = 1;
  String _quranMode = 'sequential';

  // The blocked app name for the unlock button and auto-open
  String? _resolvedAppName;

  // IDs for recording the first content block
  int? _firstQuranSurah;
  int? _firstQuranAyahStart;
  int? _firstDuaId;

  final _random = Random();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadInitial();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _extraTimer?.cancel();
    _autoSaveTimer?.cancel();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    // Save position + best-effort record reading on dispose (covers the app
    // being closed/abandoned mid-reading). Fire-and-forget: the database
    // outlives this widget, so the writes still complete.
    _saveReadingPosition();
    _recordProgress();
    super.dispose();
  }

  Timer? _autoSaveTimer;

  /// Periodically saves reading position so crashes don't lose progress.
  void _startAutoSave() {
    _autoSaveTimer?.cancel();
    _autoSaveTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      _saveReadingPosition();
    });
  }

  void _saveReadingPosition() {
    if (_quranMode == 'sequential') {
      ref.read(preferencesRepositoryProvider).updateSequentialPosition(
            _currentSeqSurah,
            _currentSeqAyah,
          );
    }
  }

  /// Auto-load more content when user scrolls near the bottom.
  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      _loadMoreContent();
    }
  }

  Future<void> _loadInitial() async {
    try {
      // Resolve the blocked app name (passed in or fetched from native)
      _resolvedAppName = widget.blockedAppName;
      if (_resolvedAppName == null) {
        try {
          _resolvedAppName =
              await ref.read(appGateServiceProvider).getLastBlockedAppName();
        } catch (e) {
          debugPrint('Last blocked app name fetch failed: $e');
        }
      }

      final prefs =
          await ref.read(preferencesRepositoryProvider).getPreferences();

      _timerSeconds = prefs.gateDurationSeconds;
      _showTranslation = prefs.showTranslation;
      _translationLanguage = prefs.translationLanguage;
      _fontSize = prefs.quranFontSize;
      _quranMode = prefs.quranMode;
      _currentSeqSurah = prefs.sequentialPositionSurah;
      _currentSeqAyah = prefs.sequentialPositionAyah;

      // If a specific content type was requested, use only that
      if (widget.initialContentType != null) {
        _enabledCategories = [
          GateContentType.fromDbValue(widget.initialContentType!)
        ];
      } else {
        // Parse enabled content categories
        _enabledCategories = prefs.gateContentCategories
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .map(GateContentType.fromDbValue)
          .where((t) => t.isFree)
          .toList();

      if (_enabledCategories.isEmpty) {
        _enabledCategories = [GateContentType.quran];
      }
      }

      // Load first batch of content (2-3 blocks)
      await _loadMoreContent(initialLoad: true);
      await _loadMoreContent();

      // Record first content block IDs for gate session
      if (_contentBlocks.isNotEmpty) {
        final first = _contentBlocks.first;
        _firstQuranSurah = first.surahNumber;
        _firstQuranAyahStart = first.ayahStart;
        _firstDuaId = first.duaId;
      }

      // Create gate session record
      _gateSessionId =
          await ref.read(gateSessionRepositoryProvider).createGateSession(
                blockedAppId: widget.blockedAppId,
                durationSeconds: _timerSeconds,
                gateContentType: _contentBlocks.isNotEmpty
                    ? _contentBlocks.first.type.dbValue
                    : 'quran',
                quranSurah: _firstQuranSurah,
                quranAyahStart: _firstQuranAyahStart,
                quranAyahEnd: _contentBlocks.isNotEmpty
                    ? _contentBlocks.first.ayahEnd
                    : null,
                duaId: _firstDuaId,
              );

      if (mounted) {
        setState(() {
          _gateState = GateState.reading;
        });
        _startTimer();
        _startAutoSave();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _gateState = GateState.error;
        });
      }
    }
  }

  /// Loads the next content block and appends it to the list.
  Future<void> _loadMoreContent({bool initialLoad = false}) async {
    if (_isLoadingMore && !initialLoad) return;
    _isLoadingMore = true;

    try {
      // Pick a random content type from enabled categories
      final type =
          _enabledCategories[_random.nextInt(_enabledCategories.length)];

      if (type == GateContentType.quran) {
        await _loadNextQuranBlock();
      } else if (type == GateContentType.dua) {
        await _loadNextDuaBlock();
      } else if (type == GateContentType.islamicTeaching) {
        await _loadNextHadithBlock();
      }

      if (mounted) setState(() {});
    } catch (e) {
      debugPrint('Error loading more content: $e');
    } finally {
      _isLoadingMore = false;
    }
  }

  /// Fetch translations for a list of ayahs in the selected language.
  Future<Map<int, String>?> _fetchTranslations(List<QuranAyah> ayahs) async {
    if (_translationLanguage == 'en') return null; // Use built-in English
    final quranRepo = ref.read(quranRepositoryProvider);
    final ids = ayahs.map((a) => a.id).toList();
    return quranRepo.getTranslationsForAyahs(ids, _translationLanguage);
  }

  Future<void> _loadNextQuranBlock() async {
    final quranRepo = ref.read(quranRepositoryProvider);
    final mode = QuranMode.fromDbValue(_quranMode);

    switch (mode) {
      case QuranMode.shortSurah:
        final content = await quranRepo.getRandomShortSurah();
        final translations = await _fetchTranslations(content.ayahs);
        _contentBlocks.add(_ContentBlock(
          type: GateContentType.quran,
          title: '${content.surah.nameEnglish} · ${content.surah.nameArabic}',
          subtitle:
              'Surah ${content.surah.number} · ${content.surah.ayahCount} Ayahs',
          ayahs: content.ayahs,
          translations: translations,
          surahNumber: content.surah.number,
          ayahStart: 1,
          ayahEnd: content.surah.ayahCount,
        ));

      case QuranMode.randomAyah:
        final content = await quranRepo.getRandomAyah();
        final translations = await _fetchTranslations([content.ayah]);
        _contentBlocks.add(_ContentBlock(
          type: GateContentType.quran,
          title: '${content.surah.nameEnglish} · ${content.surah.nameArabic}',
          subtitle: 'Ayah ${content.ayah.ayah}',
          ayahs: [content.ayah],
          translations: translations,
          surahNumber: content.surah.number,
          ayahStart: content.ayah.ayah,
          ayahEnd: content.ayah.ayah,
        ));

      case QuranMode.sequential:
        // Load a SMALL chunk within the current surah so the saved resume
        // cursor advances in small steps (≈ what was actually read), instead
        // of jumping a whole surah at a time (the old bug).
        const chunkSize = 8;
        final surah = await quranRepo.getSurah(_currentSeqSurah);
        final startAyah = _currentSeqAyah;
        final endAyah = (startAyah + chunkSize - 1).clamp(1, surah.ayahCount);
        final ayahs =
            await quranRepo.getAyahRange(_currentSeqSurah, startAyah, endAyah);

        if (ayahs.isNotEmpty) {
          final translations = await _fetchTranslations(ayahs);
          final lastAyah = ayahs.last.ayah;
          _contentBlocks.add(_ContentBlock(
            type: GateContentType.quran,
            title: '${surah.nameEnglish} · ${surah.nameArabic}',
            subtitle: 'Surah ${surah.number} · Ayahs $startAyah-$lastAyah',
            ayahs: ayahs,
            translations: translations,
            surahNumber: surah.number,
            ayahStart: startAyah,
            ayahEnd: lastAyah,
          ));

          // Advance the resume cursor: next ayah, or the first ayah of the
          // next surah once this one is finished (wrapping after Surah 114).
          if (lastAyah >= surah.ayahCount) {
            _currentSeqSurah =
                _currentSeqSurah >= 114 ? 1 : _currentSeqSurah + 1;
            _currentSeqAyah = 1;
          } else {
            _currentSeqAyah = lastAyah + 1;
          }
        }
    }
  }

  Future<void> _loadNextDuaBlock() async {
    final duaRepo = ref.read(duaRepositoryProvider);
    final dua = await duaRepo.getRandomDua();
    _contentBlocks.add(_ContentBlock(
      type: GateContentType.dua,
      title: '${dua.titleEnglish} · ${dua.titleArabic}',
      subtitle: dua.isFromQuran ? 'Quranic Dua' : 'Prophetic Dua',
      duaArabic: dua.textArabic,
      duaTranslation: dua.textTranslationEn,
      duaSource: dua.source,
      duaId: dua.id,
    ));
  }

  Future<void> _loadNextHadithBlock() async {
    final hadithRepo = ref.read(hadithRepositoryProvider);
    final hadith = await hadithRepo.getRandomHadith();
    _contentBlocks.add(_ContentBlock(
      type: GateContentType.islamicTeaching,
      title: 'Hadith',
      subtitle: hadith.sourceReference,
      hadithArabic: hadith.hadithArabic,
      hadithTranslation: hadith.hadithTranslation,
      hadithSource: hadith.sourceReference,
      hadithId: hadith.id,
    ));
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds++;
        if (_elapsedSeconds >= _timerSeconds) {
          _timer?.cancel();
          _gateState = GateState.timerComplete;
          // Record what was read once the gate is satisfied, so progress is
          // captured even if the user leaves without tapping "unlock".
          _recordProgress();
        }
      });
    });
  }

  void _startExtraReadingTimer() {
    setState(() {
      _gateState = GateState.continuing;
    });
    _extraTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _extraReadingSeconds++;
      });
    });
  }

  /// Records reading progress for everything loaded this session: marks the
  /// distinct ayahs read (idempotent — never inflates) and appends a reading
  /// event per block. Safe to call multiple times; records only once.
  Future<void> _recordProgress() async {
    if (_gateSessionId == null || _progressRecorded) return;
    _progressRecorded = true;
    final progressRepo = ref.read(readingProgressRepositoryProvider);
    final totalSeconds = _elapsedSeconds + _extraReadingSeconds;
    final perBlockSeconds = _contentBlocks.isNotEmpty
        ? totalSeconds ~/ _contentBlocks.length
        : totalSeconds;

    for (final block in _contentBlocks) {
      if (block.type == GateContentType.quran &&
          block.ayahs != null &&
          block.ayahs!.isNotEmpty) {
        await progressRepo.markAyahsRead(block.ayahs!);
        await progressRepo.logReadingEvent(
          contentType: 'quran',
          surahNumber: block.surahNumber,
          ayahStart: block.ayahStart,
          ayahEnd: block.ayahEnd,
          seconds: perBlockSeconds,
        );
        if (block.surahNumber != null) {
          await progressRepo.recordReading(
            contentType: 'quran',
            contentId: block.surahNumber!,
            readingSeconds: perBlockSeconds,
          );
        }
      } else if (block.type == GateContentType.dua && block.duaId != null) {
        await progressRepo.recordReading(
          contentType: 'dua',
          contentId: block.duaId!,
          readingSeconds: perBlockSeconds,
        );
        await progressRepo.logReadingEvent(
          contentType: 'dua',
          duaId: block.duaId,
          seconds: perBlockSeconds,
        );
      }
    }
  }

  Future<void> _unlockApp() async {
    _extraTimer?.cancel();

    // Save sequential position — wherever we've loaded up to
    await ref.read(preferencesRepositoryProvider).updateSequentialPosition(
          _currentSeqSurah,
          _currentSeqAyah,
        );

    // Complete gate session
    if (_gateSessionId != null) {
      final gateRepo = ref.read(gateSessionRepositoryProvider);

      await gateRepo.completeGateSession(
        sessionId: _gateSessionId!,
        actualDurationSeconds: _elapsedSeconds,
        extraReadingSeconds: _extraReadingSeconds,
        continuedReading: _extraReadingSeconds > 0,
      );

      // Record distinct ayahs read + an append-only reading event per block.
      await _recordProgress();

      // Update streak (pure, DST/timezone-safe arithmetic — see streak_logic.dart)
      final prefsRepo = ref.read(preferencesRepositoryProvider);
      final prefs = await prefsRepo.getPreferences();
      final now = DateTime.now();
      final today = formatStreakDate(now);
      final streak = nextStreak(
        lastDate: prefs.streakLastDate,
        current: prefs.streakCurrent,
        now: now,
      );
      if (streak != prefs.streakCurrent || prefs.streakLastDate != today) {
        await prefsRepo.updateStreak(streak, today);
      }
    }

    // Grant temporary unlock so gated apps are accessible
    int unlockMinutes = 10;
    try {
      final gateService = ref.read(appGateServiceProvider);
      final prefs = await ref.read(preferencesRepositoryProvider).getPreferences();
      unlockMinutes = prefs.unlockDurationSeconds ~/ 60;
      final duration = Duration(seconds: prefs.unlockDurationSeconds);
      await gateService.grantTemporaryUnlock('all', duration);
    } catch (e) {
      debugPrint('GateScreen: unlock grant failed: $e');
    }

    if (!mounted) return;

    // Try to open the app the user was trying to access
    final appName = _resolvedAppName;
    debugPrint('GateScreen: resolved app name = $appName');

    if (appName != null && mounted) {
      final urlScheme = _getUrlSchemeForApp(appName);
      if (urlScheme != null) {
        try {
          final gateService = ref.read(appGateServiceProvider);
          final opened = await gateService.openApp(urlScheme);
          debugPrint('GateScreen: openApp($urlScheme) = $opened');
          if (opened) return; // App opened successfully
        } catch (e) {
          debugPrint('GateScreen: open app failed: $e');
        }
      }
    }

    if (!mounted) return;

    // Fallback: show unlock message and go back
    final appLabel = appName ?? context.tr('gate_your_apps');
    final minLabel =
        unlockMinutes == 1 ? context.tr('minute') : context.tr('minutes');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            '$appLabel ${context.tr('gate_unlocked_for')} $unlockMinutes $minLabel!'),
        duration: const Duration(seconds: 3),
      ),
    );

    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/dashboard');
    }
  }

  /// Map common app names to their iOS URL schemes.
  String? _getUrlSchemeForApp(String appName) {
    final name = appName.toLowerCase();
    const schemes = {
      'instagram': 'instagram://',
      'tiktok': 'tiktok://',
      'facebook': 'fb://',
      'x': 'twitter://',
      'twitter': 'twitter://',
      'snapchat': 'snapchat://',
      'youtube': 'youtube://',
      'reddit': 'reddit://',
      'pinterest': 'pinterest://',
      'linkedin': 'linkedin://',
      'whatsapp': 'whatsapp://',
      'telegram': 'tg://',
      'discord': 'discord://',
      'messenger': 'fb-messenger://',
      'threads': 'barcelona://',
    };
    for (final entry in schemes.entries) {
      if (name.contains(entry.key)) return entry.value;
    }
    return null;
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  String _toArabicNum(int num) {
    const arabicDigits = [
      '٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'
    ];
    return num
        .toString()
        .split('')
        .map((d) => arabicDigits[int.parse(d)])
        .join();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final remaining =
        (_timerSeconds - _elapsedSeconds).clamp(0, _timerSeconds);
    final progress =
        _timerSeconds > 0 ? _elapsedSeconds / _timerSeconds : 0.0;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.gateBackgroundDark
          : AppColors.gateBackgroundLight,
      body: SafeArea(
        child: _gateState == GateState.loading
            ? const Center(child: CircularProgressIndicator())
            : _gateState == GateState.error
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Text(context.tr('gate_error_loading'),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium),
                    ),
                  )
                : Stack(
                    children: [
                      // Parchment background (light) / gold speckles (dark)
                      const Positioned.fill(
                        child: ParchmentBackground(),
                      ),
                      // Geometric background pattern
                      Positioned.fill(
                        child: IslamicGeometricPattern(
                          opacity: isDark ? 0.06 : 0.10,
                        ),
                      ),
                      // Left floral border
                      Positioned.fill(
                        child: FloralBorder(
                          opacity: isDark ? 0.12 : 0.18,
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      // Right floral border
                      Positioned.fill(
                        child: FloralBorder(
                          opacity: isDark ? 0.12 : 0.18,
                          alignment: Alignment.centerRight,
                        ),
                      ),
                      // Main content
                      Column(
                        children: [
                          _buildPrayerContextBanner(isDark),
                          // Continuous scrollable content
                          Expanded(
                            child: ListView.builder(
                              controller: _scrollController,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 24),
                              itemCount:
                                  _contentBlocks.length + 1, // +1 for loader
                              itemBuilder: (context, index) {
                                if (index == _contentBlocks.length) {
                                  // Loading indicator at bottom
                                  return const Padding(
                                    padding: EdgeInsets.all(24),
                                    child: Center(
                                      child: SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2),
                                      ),
                                    ),
                                  );
                                }

                                final block = _contentBlocks[index];
                                return _buildContentBlock(block, isDark,
                                    isFirst: index == 0);
                              },
                            ),
                          ),

                          // Timer and action area
                          _buildBottomBar(isDark, remaining, progress),
                        ],
                      ),
                    ],
                  ),
      ),
    );
  }

  /// Prayer-aware gating nudge: shows when the user opens a gated app just
  /// before or just after a prayer time.
  Widget _buildPrayerContextBanner(bool isDark) {
    final result = ref.watch(prayerTimesProvider).valueOrNull;
    if (result == null) return const SizedBox.shrink();
    final ctx = prayerContextFor(result);
    if (ctx == null) return const SizedBox.shrink();

    final primary = Theme.of(context).colorScheme.primary;
    final minLabel = ctx.minutes == 1
        ? context.tr('minute')
        : context.tr('minutes');
    final msg = ctx.isUpcoming
        ? '${ctx.prayerName} ${context.tr('gate_prayer_in')} ${ctx.minutes} $minLabel '
            '— ${context.tr('gate_prayer_prepare')} 🤲'
        : '${ctx.prayerName} ${context.tr('gate_prayer_was')} ${ctx.minutes} $minLabel '
            '${context.tr('gate_prayer_ago')} — ${context.tr('gate_prayer_did_you_pray')}';

    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: primary.withValues(alpha: isDark ? 0.16 : 0.09),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: primary.withValues(alpha: 0.28)),
      ),
      child: Row(
        children: [
          Icon(Icons.mosque_outlined, size: 20, color: primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              msg,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: primary,
                    height: 1.4,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentBlock(
      _ContentBlock block, bool isDark,
      {bool isFirst = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Decorative arabesque divider between content blocks (not before first)
        if (!isFirst)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: ManuscriptDivider(),
          ),

        // Geometric star section marker
        if (isFirst)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GeometricStarIcon(
              size: 20,
              opacity: isDark ? 0.20 : 0.25,
            ),
          ),

        // Content header wrapped in ManuscriptHeader
        ManuscriptHeader(
          height: 72,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                block.title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                block.subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isDark
                          ? AppColors.onSurfaceVariantDark
                          : AppColors.onSurfaceVariantLight,
                      letterSpacing: 0.2,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Content body wrapped in OrnateFrame
        OrnateFrame(
          opacity: isDark ? 0.12 : 0.18,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            children: [
              if (block.type == GateContentType.quran && block.ayahs != null)
                _buildQuranContent(block.ayahs!, isDark, block.translations)
              else if (block.type == GateContentType.dua)
                _buildDuaContent(block, isDark)
              else if (block.type == GateContentType.islamicTeaching)
                _buildHadithContent(block, isDark),
            ],
          ),
        ),

        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildQuranContent(
      List<QuranAyah> ayahs, bool isDark, Map<int, String>? translations) {
    return Column(
      children: [
        for (int i = 0; i < ayahs.length; i++) ...[
          if (i > 0) const SizedBox(height: 28),

          // Basmala header at the start of a surah (its own centered line),
          // except Al-Fatiha (where it is ayah 1) and At-Tawbah (no Basmala).
          if (ayahs[i].ayah == 1 && showBasmalaHeader(ayahs[i].surah)) ...[
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                kBasmala,
                style: TextStyle(
                  fontFamily: 'Amiri',
                  fontSize: _fontSize - 4,
                  height: 1.8,
                  color: isDark
                      ? AppColors.arabicTextDark
                      : AppColors.arabicTextLight,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 22),
          ],

          // Arabic ayah (Basmala stripped from ayah 1 — shown above instead)
          Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              '${stripLeadingBasmala(ayahs[i].surah, ayahs[i].textUthmani)} ﴿${_toArabicNum(ayahs[i].ayah)}﴾',
              style: TextStyle(
                fontFamily: 'Amiri',
                fontSize: _fontSize,
                height: 2.0,
                color: isDark
                    ? AppColors.arabicTextDark
                    : AppColors.arabicTextLight,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Translation (from selected language or fallback to English)
          if (_showTranslation) ...[
            () {
              final translationText = translations?[ayahs[i].id] ??
                  ayahs[i].textTranslationEn;
              if (translationText != null && translationText.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    translationText,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isDark
                              ? AppColors.onSurfaceVariantDark
                              : AppColors.onSurfaceVariantLight,
                          height: 1.7,
                        ),
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return const SizedBox.shrink();
            }(),
          ],
        ],
      ],
    );
  }

  Widget _buildDuaContent(_ContentBlock block, bool isDark) {
    return Column(
      children: [
        // Arabic text
        Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            block.duaArabic ?? '',
            style: TextStyle(
              fontFamily: 'Amiri',
              fontSize: _fontSize - 2,
              height: 2.0,
              color: isDark
                  ? AppColors.arabicTextDark
                  : AppColors.arabicTextLight,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        // Translation
        if (_showTranslation && block.duaTranslation != null) ...[
          const SizedBox(height: 16),
          Text(
            block.duaTranslation!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isDark
                      ? AppColors.onSurfaceVariantDark
                      : AppColors.onSurfaceVariantLight,
                  height: 1.7,
                ),
            textAlign: TextAlign.center,
          ),
        ],

        // Source reference
        if (block.duaSource != null) ...[
          const SizedBox(height: 12),
          Text(
            block.duaSource!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isDark
                      ? AppColors.onSurfaceVariantDark.withValues(alpha: 0.7)
                      : AppColors.onSurfaceVariantLight.withValues(alpha: 0.7),
                  fontStyle: FontStyle.italic,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }

  Widget _buildHadithContent(_ContentBlock block, bool isDark) {
    return Column(
      children: [
        // Arabic text (if available)
        if (block.hadithArabic != null && block.hadithArabic!.isNotEmpty) ...[
          Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              block.hadithArabic!,
              style: TextStyle(
                fontFamily: 'Amiri',
                fontSize: _fontSize - 4,
                height: 2.0,
                color: isDark
                    ? AppColors.arabicTextDark
                    : AppColors.arabicTextLight,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
        ],

        // English translation
        if (block.hadithTranslation != null) ...[
          Text(
            block.hadithTranslation!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isDark
                      ? AppColors.onSurfaceDark
                      : AppColors.onSurfaceLight,
                  height: 1.8,
                ),
            textAlign: TextAlign.center,
          ),
        ],

        // Source reference
        if (block.hadithSource != null) ...[
          const SizedBox(height: 16),
          Text(
            block.hadithSource!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isDark
                      ? AppColors.onSurfaceVariantDark
                      : AppColors.onSurfaceVariantLight,
                  fontStyle: FontStyle.italic,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }

  Widget _buildBottomBar(bool isDark, int remaining, double progress) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 24),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_gateState == GateState.reading) ...[
            GateTimer(
              progress: progress.clamp(0.0, 1.0),
              timeText: _formatTime(remaining),
              isDark: isDark,
            ),
            const SizedBox(height: 12),
            Text(
              context.tr('gate_spend_time'),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isDark
                        ? AppColors.onSurfaceVariantDark
                        : AppColors.onSurfaceVariantLight,
                  ),
              textAlign: TextAlign.center,
            ),
          ] else if (_gateState == GateState.timerComplete) ...[
            Text(
              _resolvedAppName != null
                  ? '${context.tr('gate_ready_to_open')} $_resolvedAppName'
                  : context.tr('gate_reading_complete'),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _unlockApp,
                child: Text(_resolvedAppName != null
                    ? '${context.tr('gate_continue_to')} $_resolvedAppName'
                    : context.tr('gate_unlock_my_apps')),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: _startExtraReadingTimer,
                child: Text(context.tr('gate_continue_reading')),
              ),
            ),
          ] else ...[
            // Continuing state
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.auto_stories,
                  size: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  '${context.tr('gate_extra_reading')} ${_formatTime(_extraReadingSeconds)}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _unlockApp,
                child: Text(_resolvedAppName != null
                    ? '${context.tr('gate_continue_to')} $_resolvedAppName'
                    : context.tr('gate_unlock_my_apps')),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
