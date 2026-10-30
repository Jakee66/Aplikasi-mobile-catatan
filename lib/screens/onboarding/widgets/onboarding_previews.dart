import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../widgets/user_avatar.dart';
import '../onboarding_slide.dart';

/// Mockup mini untuk tiap slide tutorial.
///
/// Elemen yang menjadi sasaran kursor diberi `targetKey(id)` sehingga posisi
/// kursor diukur dari layout sebenarnya (tidak perlu menebak koordinat).

class WelcomePreview extends StatelessWidget {
  const WelcomePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primary,
            child: Icon(Icons.sticky_note_2_rounded, color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(
            'CatatAja Mobile',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
          ),
          Text(
            'Simpan Ide & Catatan Bersama',
            style: TextStyle(fontSize: 10, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}

class TabsPreview extends StatelessWidget {
  const TabsPreview({
    super.key,
    required this.isSharedActive,
    required this.targetKey,
  });

  static const sharedTabId = 0;
  static const personalTabId = 1;

  final bool isSharedActive;
  final TargetKeyOf targetKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Expanded(
                child: _DemoTab(
                  key: targetKey(personalTabId),
                  label: 'Pribadi',
                  isActive: !isSharedActive,
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _DemoTab(
                  key: targetKey(sharedTabId),
                  label: 'Bersama',
                  isActive: isSharedActive,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _DemoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isSharedActive ? 'Contoh Catatan Kelompok' : 'Contoh Catatan Pribadi',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const UserAvatar(initial: 'M', size: 18, isOwner: true),
                  if (isSharedActive) ...[
                    const SizedBox(width: 4),
                    const UserAvatar(initial: 'B', size: 18),
                    const SizedBox(width: 6),
                    const Text(
                      '2 Kolaborator',
                      style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class InvitePreview extends StatelessWidget {
  const InvitePreview({super.key, required this.targetKey});

  static const addButtonId = 0;

  final TargetKeyOf targetKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Undang Kolaborator:',
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        const Wrap(
          spacing: 6,
          children: [
            _DemoChip(label: 'Budi Santoso', isSelected: true),
            _DemoChip(label: '+ Siti Rahma'),
          ],
        ),
        const Spacer(),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            key: targetKey(addButtonId),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.add_rounded, color: Colors.white, size: 20),
          ),
        ),
      ],
    );
  }
}

class FriendPreview extends StatelessWidget {
  const FriendPreview({super.key, required this.targetKey});

  static const addButtonId = 0;

  final TargetKeyOf targetKey;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _DemoCard(
        child: Row(
          children: [
            const UserAvatar(initial: 'R', size: 26),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                'Rian Prasetya',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
              ),
            ),
            _DemoButton(key: targetKey(addButtonId), label: '+ Tambah'),
          ],
        ),
      ),
    );
  }
}

class MemberPreview extends StatelessWidget {
  const MemberPreview({super.key, required this.targetKey});

  static const addButtonId = 0;

  final TargetKeyOf targetKey;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.primarySoft,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.primarySoftBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Anggota Kolaborator',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                _DemoButton(key: targetKey(addButtonId), label: '+ Tambah'),
              ],
            ),
            const SizedBox(height: 8),
            const Wrap(
              spacing: 4,
              children: [
                _DemoChip(label: 'Saya'),
                _DemoChip(label: 'Budi'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --- Elemen kecil pendukung -------------------------------------------------

class _DemoTab extends StatelessWidget {
  const _DemoTab({super.key, required this.label, required this.isActive});

  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(vertical: 6),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.divider,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: isActive ? Colors.white : AppColors.textSecondary,
        ),
      ),
    );
  }
}

class _DemoCard extends StatelessWidget {
  const _DemoCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: child,
    );
  }
}

class _DemoChip extends StatelessWidget {
  const _DemoChip({required this.label, this.isSelected = false});

  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.border,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: isSelected ? Colors.white : AppColors.textSecondary,
        ),
      ),
    );
  }
}

class _DemoButton extends StatelessWidget {
  const _DemoButton({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}