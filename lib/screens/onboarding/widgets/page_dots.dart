import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class PageDots extends StatelessWidget {
  const PageDots({super.key, required this.count, required this.current});

  final int count;
  final int current;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: i == current ? 20 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: i == current ? AppColors.primary : AppColors.border,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
      ],
    );
  }
}
