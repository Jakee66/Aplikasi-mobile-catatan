import 'package:flutter/material.dart';

import '../../core/navigation/app_navigator.dart';
import '../../core/theme/app_colors.dart';
import 'onboarding_data.dart';
import 'widgets/cursor_demo_stage.dart';
import 'widgets/page_dots.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static final _slides = OnboardingData.slides;

  int _index = 0;

  bool get _isFirst => _index == 0;
  bool get _isLast => _index == _slides.length - 1;

  void _next() {
    if (_isLast) {
      AppNavigator.toLogin(context);
    } else {
      setState(() => _index++);
    }
  }

  void _previous() {
    if (!_isFirst) setState(() => _index--);
  }

  @override
  Widget build(BuildContext context) {
    final slide = _slides[_index];

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _TopBar(onSkip: () => AppNavigator.toLogin(context)),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CursorDemoStage(key: ValueKey(_index), slide: slide),
                        const SizedBox(height: 24),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: Column(
                            key: ValueKey(_index),
                            children: [
                              Text(
                                slide.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                slide.description,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 13,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              PageDots(count: _slides.length, current: _index),
              const SizedBox(height: 16),
              Row(
                children: [
                  if (!_isFirst) ...[
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        onPressed: _previous,
                        child: const Text('Kembali'),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                  Expanded(
                    flex: 2,
                    child: FilledButton(
                      onPressed: _next,
                      child: Text(_isLast ? 'Mulai Sekarang' : 'Lanjut'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onSkip});

  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primarySoft,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primarySoftBorder),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.touch_app_rounded, size: 13, color: AppColors.primary),
              SizedBox(width: 4),
              Text(
                'PETUNJUK KURSOR',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: onSkip,
          child: const Text('Lewati', style: TextStyle(color: AppColors.textMuted)),
        ),
      ],
    );
  }
}
