import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';

/// Daftar anggota kolaborator + tombol untuk menambah anggota.
class MembersPanel extends StatelessWidget {
  const MembersPanel({
    super.key,
    required this.collaborators,
    required this.onAddMember,
  });

  final List<String> collaborators;
  final VoidCallback onAddMember;

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
          Row(
            children: [
              const Icon(Icons.groups_rounded, size: 16, color: AppColors.primary),
              const SizedBox(width: 6),
              const Expanded(
                child: Text(
                  'ANGGOTA KOLABORATOR',
                  style: TextStyle(
                    color: AppColors.primaryDark,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: onAddMember,
                style: TextButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                ),
                icon: const Icon(Icons.person_add_alt_1_rounded, size: 14),
                label: const Text(
                  'Tambah Anggota',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              const _MemberChip(
                label: '${AppConstants.ownerLabel} (Pemilik)',
                isOwner: true,
              ),
              for (final name in collaborators) _MemberChip(label: name),
            ],
          ),
        ],
      ),
    );
  }
}

class _MemberChip extends StatelessWidget {
  const _MemberChip({required this.label, this.isOwner = false});

  final String label;
  final bool isOwner;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isOwner ? AppColors.primary : AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isOwner ? AppColors.primary : AppColors.primarySoftBorder,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isOwner ? Colors.white : AppColors.textPrimary,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
