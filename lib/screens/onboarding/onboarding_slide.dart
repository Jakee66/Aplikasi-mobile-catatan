import 'package:flutter/widgets.dart';

/// Mengembalikan key untuk elemen mockup yang menjadi sasaran kursor.
typedef TargetKeyOf = GlobalKey Function(int targetId);

/// Satu langkah kursor animasi: menunjuk elemen mockup, atau titik bebas.
class CursorStep {
  /// Kursor menuju elemen yang diberi `targetKey(targetId)` di mockup.
  /// Posisinya diukur langsung dari layout, jadi selalu tepat sasaran.
  const CursorStep.target(this.targetId, this.label)
      : alignment = Alignment.center;

  /// Kursor berada di titik bebas (dipakai sebagai posisi awal).
  const CursorStep.at(this.alignment, this.label) : targetId = null;

  final int? targetId;
  final Alignment alignment;

  /// Teks petunjuk yang tampil di bawah kotak peraga.
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
  final Widget Function(BuildContext context, int step, TargetKeyOf targetKey)
      previewBuilder;

  /// Kosong = tanpa kursor.
  final List<CursorStep> cursorSteps;

  /// `true`: kursor berpindah bolak-balik tiap 1 detik.
  /// `false`: kursor bergerak satu kali ke langkah terakhir.
  final bool loopCursor;

  bool get hasCursor => cursorSteps.isNotEmpty;
}