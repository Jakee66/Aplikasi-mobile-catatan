import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../onboarding_slide.dart';

/// Kotak peraga: menampilkan mockup slide + kursor animasi di atasnya.
///
/// Posisi kursor diukur dari elemen mockup yang sebenarnya (lewat GlobalKey),
/// sehingga selalu tepat di tombol/tab yang dimaksud.
/// Beri `key` berbeda untuk tiap slide agar animasi mulai dari awal.
class CursorDemoStage extends StatefulWidget {
  const CursorDemoStage({super.key, required this.slide});

  final OnboardingSlide slide;

  @override
  State<CursorDemoStage> createState() => _CursorDemoStageState();
}

class _CursorDemoStageState extends State<CursorDemoStage> {
  static const _stageHeight = 200.0;
  static const _cursorSize = 40.0;

  // Atur kecepatan animasi di sini (makin besar = makin lambat).
  static const _moveDuration = Duration(milliseconds: 1300);
  static const _loopInterval = Duration(milliseconds: 2800);
  static const _startDelay = Duration(milliseconds: 900);
  static const _clickDuration = Duration(milliseconds: 450);
  static const _moveCurve = Curves.easeInOutCubic;

  final _stageKey = GlobalKey();
  final _targetKeys = <int, GlobalKey>{};

  Timer? _stepTimer;
  Timer? _arriveTimer;
  Timer? _clickTimer;
  Timer? _fadeInTimer;

  /// Langkah tujuan kursor.
  int _step = 0;

  /// Langkah yang sedang ditampilkan mockup. Baru berubah setelah kursor tiba.
  int _previewStep = 0;

  bool _isClicking = false;
  bool _cursorVisible = false;

  /// Titik yang ditunjuk kursor, relatif terhadap kotak peraga.
  Offset? _cursorPoint;

  OnboardingSlide get _slide => widget.slide;

  GlobalKey _targetKey(int id) => _targetKeys.putIfAbsent(id, () => GlobalKey());

  @override
  void initState() {
    super.initState();
    if (!_slide.hasCursor) return;

    _syncCursorToStep();
    if (_slide.loopCursor) {
      _startLooping();
    } else {
      _startSingleMove();
    }
  }

  @override
  void dispose() {
    _stepTimer?.cancel();
    _arriveTimer?.cancel();
    _clickTimer?.cancel();
    _fadeInTimer?.cancel();
    super.dispose();
  }

  // --- Animasi --------------------------------------------------------------

  /// Slide dengan kursor bolak-balik: geser -> tiba -> klik -> tahan -> ulang.
  void _startLooping() {
    _stepTimer = Timer.periodic(_loopInterval, (_) {
      setState(() => _step = (_step + 1) % _slide.cursorSteps.length);
      _syncCursorToStep();
      _clickWhenArrived();
    });
  }

  /// Slide dengan satu gerakan: tunggu sebentar -> geser -> tiba -> klik.
  void _startSingleMove() {
    _stepTimer = Timer(_startDelay, () {
      setState(() => _step = _slide.cursorSteps.length - 1);
      _syncCursorToStep();
      _clickWhenArrived();
    });
  }

  /// Setelah kursor tiba: tampilkan efek klik dan perbarui mockup.
  void _clickWhenArrived() {
    _arriveTimer?.cancel();
    _arriveTimer = Timer(_moveDuration, () {
      if (!mounted) return;
      setState(() {
        _previewStep = _step;
        _isClicking = true;
      });
      _clickTimer?.cancel();
      _clickTimer = Timer(_clickDuration, () {
        if (mounted) setState(() => _isClicking = false);
      });
    });
  }

  // --- Pengukuran posisi ----------------------------------------------------

  /// Mengukur posisi langkah saat ini setelah frame selesai di-layout.
  void _syncCursorToStep() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final point = _measurePoint(_slide.cursorSteps[_step]);
      if (point == null) return;

      final isFirstPlacement = _cursorPoint == null;
      setState(() => _cursorPoint = point);

      if (isFirstPlacement) {
        // Muncul perlahan (fade-in) di posisi awal.
        _fadeInTimer = Timer(const Duration(milliseconds: 60), () {
          if (mounted) setState(() => _cursorVisible = true);
        });
      }
    });
  }

  Offset? _measurePoint(CursorStep step) {
    final stageBox = _stageKey.currentContext?.findRenderObject() as RenderBox?;
    if (stageBox == null || !stageBox.hasSize) return null;

    final targetId = step.targetId;
    if (targetId != null) {
      final targetBox =
          _targetKeys[targetId]?.currentContext?.findRenderObject() as RenderBox?;
      if (targetBox != null && targetBox.hasSize) {
        return targetBox.localToGlobal(
          targetBox.size.center(Offset.zero),
          ancestor: stageBox,
        );
      }
    }
    return step.alignment.alongSize(stageBox.size);
  }

  // --- UI -------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final point = _cursorPoint;

    return Container(
      key: _stageKey,
      height: _stageHeight,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Stack(
        children: [
          // Sisakan ruang di bawah untuk teks petunjuk.
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.fromLTRB(14, 14, 14, _slide.hasCursor ? 44 : 14),
              child: _slide.previewBuilder(context, _previewStep, _targetKey),
            ),
          ),
          if (_slide.hasCursor) ...[
            Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: Center(child: _HintChip(label: _slide.cursorSteps[_step].label)),
            ),
            if (point != null)
              AnimatedPositioned(
                duration: _moveDuration,
                curve: _moveCurve,
                // Ujung jari ikon berada di sekitar tengah-atas kotak kursor.
                left: point.dx - _cursorSize / 2 + 2,
                top: point.dy - 8,
                child: IgnorePointer(
                  child: AnimatedOpacity(
                    opacity: _cursorVisible ? 1 : 0,
                    duration: const Duration(milliseconds: 400),
                    child: _DemoCursor(isClicking: _isClicking),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _DemoCursor extends StatelessWidget {
  const _DemoCursor({required this.isClicking});

  final bool isClicking;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _CursorDemoStageState._cursorSize,
      height: _CursorDemoStageState._cursorSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Efek riak saat "klik".
          Positioned(
            top: 0,
            child: AnimatedScale(
              scale: isClicking ? 1.1 : 0.3,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                opacity: isClicking ? 1 : 0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withValues(alpha: 0.3),
                  ),
                ),
              ),
            ),
          ),
          // Kursor sedikit mengecil saat "menekan".
          Positioned(
            top: 0,
            child: AnimatedScale(
              scale: isClicking ? 0.88 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: const Icon(
                Icons.touch_app_rounded,
                color: AppColors.primary,
                size: 30,
                shadows: [Shadow(color: Colors.black26, blurRadius: 4)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HintChip extends StatelessWidget {
  const _HintChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.textPrimary.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}