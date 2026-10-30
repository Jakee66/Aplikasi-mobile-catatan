import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../onboarding_slide.dart';

/// Kotak peraga: menampilkan mockup slide + kursor animasi di atasnya.
///
/// Berikan `key` yang berbeda untuk tiap slide agar animasi mulai dari awal.
class CursorDemoStage extends StatefulWidget {
  const CursorDemoStage({super.key, required this.slide});

  final OnboardingSlide slide;

  @override
  State<CursorDemoStage> createState() => _CursorDemoStageState();
}

class _CursorDemoStageState extends State<CursorDemoStage> {
  static const _loopInterval = Duration(seconds: 1);
  static const _startDelay = Duration(milliseconds: 500);
  static const _clickDuration = Duration(milliseconds: 350);

  Timer? _stepTimer;
  Timer? _clickTimer;
  int _step = 0;
  bool _isClicking = false;

  OnboardingSlide get _slide => widget.slide;

  @override
  void initState() {
    super.initState();
    if (_slide.hasCursor) _startAnimation();
  }

  @override
  void dispose() {
    _stepTimer?.cancel();
    _clickTimer?.cancel();
    super.dispose();
  }

  void _startAnimation() {
    if (_slide.loopCursor) {
      _isClicking = true;
      _scheduleClickRelease();
      _stepTimer = Timer.periodic(_loopInterval, (_) {
        setState(() {
          _step = (_step + 1) % _slide.cursorSteps.length;
          _isClicking = true;
        });
        _scheduleClickRelease();
      });
    } else {
      _stepTimer = Timer(_startDelay, () {
        setState(() => _step = _slide.cursorSteps.length - 1);
        // Klik tepat setelah kursor tiba di tujuan.
        _clickTimer = Timer(const Duration(milliseconds: 900), () {
          if (!mounted) return;
          setState(() => _isClicking = true);
          _scheduleClickRelease();
        });
      });
    }
  }

  void _scheduleClickRelease() {
    _clickTimer?.cancel();
    _clickTimer = Timer(_clickDuration, () {
      if (mounted) setState(() => _isClicking = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: _slide.previewBuilder(context, _step),
            ),
          ),
          if (_slide.hasCursor)
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeInOutCubic,
                  alignment: _slide.cursorSteps[_step].alignment,
                  child: _DemoCursor(
                    label: _slide.cursorSteps[_step].label,
                    isClicking: _isClicking,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _DemoCursor extends StatelessWidget {
  const _DemoCursor({required this.label, required this.isClicking});

  final String label;
  final bool isClicking;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedScale(
                scale: isClicking ? 1.0 : 0.3,
                duration: const Duration(milliseconds: 250),
                child: AnimatedOpacity(
                  opacity: isClicking ? 1 : 0,
                  duration: const Duration(milliseconds: 250),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withValues(alpha: 0.3),
                    ),
                  ),
                ),
              ),
              const Icon(Icons.touch_app_rounded, color: AppColors.primary, size: 28),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.textPrimary.withValues(alpha: 0.92),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
