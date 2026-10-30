import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../models/note.dart';

/// Chip filter kategori. `null` berarti "Semua".
class CategoryFilterBar extends StatelessWidget {
  const CategoryFilterBar({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final NoteCategory? selected;
  final ValueChanged<NoteCategory?> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _FilterChip(
            label: 'Semua',
            isSelected: selected == null,
            onTap: () => onSelected(null),
          ),
          for (final category in NoteCategory.values)
            _FilterChip(
              label: category.label,
              isSelected: selected == category,
              onTap: () => onSelected(category),
            ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onTap(),
        showCheckmark: false,
        labelStyle: TextStyle(
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
          color: isSelected ? Colors.white : AppColors.textSecondary,
        ),
        selectedColor: AppColors.primary,
        backgroundColor: AppColors.surface,
        side: BorderSide(
          color: isSelected ? AppColors.primary : AppColors.border,
        ),
        shape: const StadiumBorder(),
      ),
    );
  }
}
