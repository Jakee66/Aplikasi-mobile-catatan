import 'package:flutter/widgets.dart';

/// Satu titik tujuan kursor animasi beserta label tooltip-nya.
class CursorStep {
  const CursorStep(this.alignment, this.label);

  final Alignment alignment;
  final String label;
}

/// Data satu slide tutorial.
class OnboardingSlide {
  const OnboardingSlide({
    required this.title,
    required this.description,
    required this.previewBuilder,
    this.cursorSteps = const [],
    this.loopCursor = false,
  });

  final String title;
  final String description;

  /// Mockup kecil layar yang dijelaskan. [step] = langkah kursor saat ini.
  final Widget Function(BuildContext context, int step) previewBuilder;

  /// Kosong = tanpa kursor.
  final List<CursorStep> cursorSteps;

  /// `true`: kursor berpindah bolak-balik tiap 1 detik.
  /// `false`: kursor bergerak satu kali ke langkah terakhir.
  final bool loopCursor;

  bool get hasCursor => cursorSteps.isNotEmpty;
}
