import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../state/app_scope.dart';
import 'user_avatar.dart';

/// Bottom sheet untuk mengundang teman ke catatan bersama yang sudah ada.
Future<void> showAddMemberSheet(BuildContext context, {required String noteId}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (_) => _AddMemberSheet(noteId: noteId),
  );
}

class _AddMemberSheet extends StatelessWidget {
  const _AddMemberSheet({required this.noteId});

  final String noteId;

  @override
  Widget build(BuildContext context) {
    final controller = AppScope.of(context);
    final note = controller.noteById(noteId);
    final candidates = controller.addedFriends
        .where((friend) => !(note?.collaborators.contains(friend.name) ?? true))
        .toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Undang Anggota Baru',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close_rounded, size: 20),
                ),
              ],
            ),
            const Text(
              'Pilih teman untuk ditambahkan ke catatan ini:',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),
            const SizedBox(height: 12),
            if (candidates.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Semua teman Anda sudah bergabung di catatan ini.',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 12),
                ),
              )
            else
              for (final friend in candidates)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      UserAvatar(initial: friend.initial, size: 34),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          friend.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      FilledButton(
                        onPressed: () {
                          AppScope.read(context)
                              .addCollaborator(noteId, friend.name);
                          Navigator.of(context).pop();
                        },
                        style: FilledButton.styleFrom(
                          minimumSize: const Size(0, 32),
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          textStyle: const TextStyle(fontSize: 11),
                        ),
                        child: const Text('Undang'),
                      ),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
