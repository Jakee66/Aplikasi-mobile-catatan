import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// Label kecil huruf kapital di atas sebuah input.
class FieldLabel extends StatelessWidget {
  const FieldLabel(this.text, {super.key, this.color = AppColors.textSecondary});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
