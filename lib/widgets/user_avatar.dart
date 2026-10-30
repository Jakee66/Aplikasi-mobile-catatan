import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// Avatar bulat dengan inisial.
class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.initial,
    this.size = 32,
    this.isOwner = false,
    this.ringColor,
  });

  final String initial;
  final double size;
  final bool isOwner;

  /// Cincin tipis di sekeliling avatar (berguna saat avatar bertumpuk).
  final Color? ringColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isOwner ? AppColors.primary : const Color(0xFFDDD6FE),
        border: ringColor == null ? null : Border.all(color: ringColor!, width: 1.5),
      ),
      child: Text(
        initial,
        style: TextStyle(
          fontSize: size * 0.42,
          fontWeight: FontWeight.w800,
          color: isOwner ? Colors.white : const Color(0xFF5B21B6),
        ),
      ),
    );
  }
}
