import 'package:flutter/material.dart';

// ============================================================================
// Manuscript Decoration Widgets
//
// Ottoman/Mughal-inspired decorative widgets using generated PNG assets.
// These create a rich illuminated manuscript feel for the app.
// ============================================================================

/// Asset paths for manuscript decorations.
abstract final class _Assets {
  static const String borderCorner = 'assets/images/border_corner.png';
  static const String borderSideTop = 'assets/images/border_side_top.png';
  static const String dividerFloral = 'assets/images/divider_floral.png';
  static const String headerIllumination =
      'assets/images/header_illumination.png';
  static const String roseAccent = 'assets/images/rose_accent.png';
  static const String vineVertical = 'assets/images/vine_border_vertical.png';
  static const String goldSpeckle = 'assets/images/gold_speckle_overlay.png';
  static const String parchmentTexture = 'assets/images/parchment_texture.png';
}

// ── ManuscriptPageFrame ──────────────────────────────────────────────────────

/// Wraps content in an illuminated manuscript-style frame with corner pieces,
/// optional top border, parchment background, and gold speckle overlay.
class ManuscriptPageFrame extends StatelessWidget {
  const ManuscriptPageFrame({
    required this.child,
    super.key,
    this.showCorners = true,
    this.showTopBorder = false,
    this.showParchment = true,
    this.showGoldSpeckle = true,
    this.cornerSize = 80,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final bool showCorners;
  final bool showTopBorder;
  final bool showParchment;
  final bool showGoldSpeckle;
  final double cornerSize;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Reduce opacity on dark backgrounds
    final decorOpacity = isDark ? 0.35 : 1.0;

    return Stack(
      children: [
        // Parchment background
        if (showParchment)
          Positioned.fill(
            child: Opacity(
              opacity: isDark ? 0.15 : 1.0,
              child: const ParchmentBackground(showGoldSpeckle: false),
            ),
          ),

        // Gold speckle overlay
        if (showGoldSpeckle)
          Positioned.fill(
            child: Opacity(
              opacity: isDark ? 0.3 : 0.5,
              child: Image.asset(
                _Assets.goldSpeckle,
                repeat: ImageRepeat.repeat,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),

        // Content
        Padding(
          padding: padding,
          child: child,
        ),

        // Corner decorations
        if (showCorners) ...[
          // Top-left (original orientation)
          Positioned(
            top: 0,
            left: 0,
            child: Opacity(
              opacity: decorOpacity,
              child: Image.asset(
                _Assets.borderCorner,
                width: cornerSize,
                height: cornerSize,
              ),
            ),
          ),
          // Top-right (flipped horizontally)
          Positioned(
            top: 0,
            right: 0,
            child: Opacity(
              opacity: decorOpacity,
              child: Transform.flip(
                flipX: true,
                child: Image.asset(
                  _Assets.borderCorner,
                  width: cornerSize,
                  height: cornerSize,
                ),
              ),
            ),
          ),
          // Bottom-left (flipped vertically)
          Positioned(
            bottom: 0,
            left: 0,
            child: Opacity(
              opacity: decorOpacity,
              child: Transform.flip(
                flipY: true,
                child: Image.asset(
                  _Assets.borderCorner,
                  width: cornerSize,
                  height: cornerSize,
                ),
              ),
            ),
          ),
          // Bottom-right (flipped both)
          Positioned(
            bottom: 0,
            right: 0,
            child: Opacity(
              opacity: decorOpacity,
              child: Transform.flip(
                flipX: true,
                flipY: true,
                child: Image.asset(
                  _Assets.borderCorner,
                  width: cornerSize,
                  height: cornerSize,
                ),
              ),
            ),
          ),
        ],

        // Top border
        if (showTopBorder)
          Positioned(
            top: 0,
            left: cornerSize * 0.5,
            right: cornerSize * 0.5,
            child: Opacity(
              opacity: decorOpacity,
              child: Image.asset(
                _Assets.borderSideTop,
                fit: BoxFit.fitWidth,
                height: cornerSize * 0.35,
              ),
            ),
          ),
      ],
    );
  }
}

// ── ManuscriptDivider ────────────────────────────────────────────────────────

/// A floral divider using the generated divider_floral.png asset.
class ManuscriptDivider extends StatelessWidget {
  const ManuscriptDivider({
    super.key,
    this.width,
    this.height = 32,
  });

  final double? width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Opacity(
      opacity: isDark ? 0.4 : 0.85,
      child: Image.asset(
        _Assets.dividerFloral,
        width: width,
        height: height,
        fit: BoxFit.contain,
      ),
    );
  }
}

// ── ManuscriptHeader ─────────────────────────────────────────────────────────

/// An illuminated header panel inspired by Quran surah headers.
/// Renders the header_illumination.png behind the provided text.
class ManuscriptHeader extends StatelessWidget {
  const ManuscriptHeader({
    required this.child,
    super.key,
    this.height = 80,
  });

  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background illumination
          Positioned.fill(
            child: Opacity(
              opacity: isDark ? 0.3 : 0.7,
              child: Image.asset(
                _Assets.headerIllumination,
                fit: BoxFit.fill,
              ),
            ),
          ),
          // Text content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: child,
          ),
        ],
      ),
    );
  }
}

// ── RoseAccent ───────────────────────────────────────────────────────────────

/// A small decorative rose accent that can be placed alongside text or headings.
class RoseAccent extends StatelessWidget {
  const RoseAccent({
    super.key,
    this.size = 40,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Opacity(
      opacity: isDark ? 0.5 : 0.9,
      child: Image.asset(
        _Assets.roseAccent,
        width: size,
        height: size,
      ),
    );
  }
}

// ── ParchmentBackground ──────────────────────────────────────────────────────

/// A warm parchment background with optional gold speckle overlay.
/// Tiles the parchment_texture.png and gold_speckle_overlay.png.
class ParchmentBackground extends StatelessWidget {
  const ParchmentBackground({
    super.key,
    this.showGoldSpeckle = true,
  });

  final bool showGoldSpeckle;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isDark) {
      // Dark mode: just subtle gold speckles on the dark background
      return showGoldSpeckle
          ? Opacity(
              opacity: 0.25,
              child: Image.asset(
                _Assets.goldSpeckle,
                repeat: ImageRepeat.repeat,
                width: double.infinity,
                height: double.infinity,
              ),
            )
          : const SizedBox.shrink();
    }

    return Stack(
      children: [
        // Parchment base
        Positioned.fill(
          child: Image.asset(
            _Assets.parchmentTexture,
            repeat: ImageRepeat.repeat,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        // Gold speckle overlay
        if (showGoldSpeckle)
          Positioned.fill(
            child: Opacity(
              opacity: 0.4,
              child: Image.asset(
                _Assets.goldSpeckle,
                repeat: ImageRepeat.repeat,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
      ],
    );
  }
}

// ── VineBorderVertical ───────────────────────────────────────────────────────

/// A vertical vine border for page edges, using vine_border_vertical.png.
class VineBorderVertical extends StatelessWidget {
  const VineBorderVertical({
    super.key,
    this.width = 24,
    this.alignment = Alignment.centerLeft,
  });

  final double width;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isRight = alignment == Alignment.centerRight;

    return Opacity(
      opacity: isDark ? 0.3 : 0.6,
      child: Transform.flip(
        flipX: isRight,
        child: Image.asset(
          _Assets.vineVertical,
          width: width,
          fit: BoxFit.fitWidth,
          repeat: ImageRepeat.repeatY,
        ),
      ),
    );
  }
}
