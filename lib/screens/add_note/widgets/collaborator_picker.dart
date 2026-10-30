import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../models/friend.dart';
import '../../../widgets/field_label.dart';

/// Panel untuk memilih teman yang diundang ke catatan bersama.
class CollaboratorPicker extends StatelessWidget {
  const CollaboratorPicker({
    super.key,
    required this.friends,
    required this.selected,
    required this.onToggle,
  });

  final List<Friend> friends;
  final Set<String> selected;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.primarySoftBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FieldLabel('Undang Teman / Kolaborator', color: AppColors.primary),
          const Text(
            'Pilih teman yang ingin dimasukkan ke dalam catatan bersama ini:',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 11),
          ),
          const SizedBox(height: 10),
          if (friends.isEmpty)
            const Text(
              'Belum ada teman. Tambah teman di Beranda.',
              style: TextStyle(color: AppColors.textMuted, fontSize: 11),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final friend in friends)
                  FilterChip(
                    label: Text(friend.name),
                    selected: selected.contains(friend.name),
                    onSelected: (_) => onToggle(friend.name),
                    showCheckmark: true,
                    checkmarkColor: Colors.white,
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: selected.contains(friend.name)
                          ? Colors.white
                          : AppColors.textSecondary,
                    ),
                    selectedColor: AppColors.primary,
                    backgroundColor: AppColors.surface,
                    side: BorderSide(
                      color: selected.contains(friend.name)
                          ? AppColors.primary
                          : AppColors.border,
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
