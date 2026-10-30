import 'package:flutter/material.dart';

abstract final class AppColors {
  static const primary = Color(0xFF4F46E5);
  static const primaryDark = Color(0xFF312E81);
  static const accent = Color(0xFF7C3AED);
  static const primarySoft = Color(0xFFEEF2FF);
  static const primarySoftBorder = Color(0xFFE0E7FF);

  static const background = Color(0xFFF8FAFC);
  static const surface = Colors.white;
  static const border = Color(0xFFE2E8F0);
  static const divider = Color(0xFFF1F5F9);

  static const textPrimary = Color(0xFF1E293B);
  static const textSecondary = Color(0xFF64748B);
  static const textMuted = Color(0xFF94A3B8);

  static const danger = Color(0xFFEF4444);
  static const dangerSoft = Color(0xFFFEF2F2);

  static const primaryGradient = LinearGradient(
    colors: [primary, accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const splashGradient = LinearGradient(
    colors: [Color(0xFF4338CA), primary, Color(0xFF6D28D9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
