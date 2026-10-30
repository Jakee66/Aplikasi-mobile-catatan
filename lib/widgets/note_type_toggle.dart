import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../models/note.dart';

/// Toggle dua pilihan: Catatan Pribadi / Catatan Bersama.
class NoteTypeToggle extends StatelessWidget {
  const NoteTypeToggle({
    super.key,
    required this.selected,
    required this.onChanged,
    this.showIcons = true,
  });

  final NoteType selected;
  final ValueChanged<NoteType> onChanged;
  final bool showIcons;

  static IconData _iconOf(NoteType type) => switch (type) {
        NoteType.personal => Icons.person_rounded,
        NoteType.shared => Icons.groups_rounded,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0).withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          for (final type in NoteType.values)
            Expanded(
              child: _ToggleItem(
                label: type.label,
                icon: showIcons ? _iconOf(type) : null,
                isSelected: type == selected,
                onTap: () => onChanged(type),
              ),
            ),
        ],
      ),
    );
  }
}

class _ToggleItem extends StatelessWidget {
  const _ToggleItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.icon,
  });

  final String label;
  final IconData? icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.primary : AppColors.textSecondary;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 15, color: color),
              const SizedBox(width: 6),
            ],
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: color,
                  fontSize: 12.5,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
