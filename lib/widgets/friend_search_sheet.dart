import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../models/friend.dart';
import '../state/app_scope.dart';
import 'user_avatar.dart';

/// Bottom sheet untuk mencari dan menambahkan teman.
Future<void> showFriendSearchSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (_) => const _FriendSearchSheet(),
  );
}

class _FriendSearchSheet extends StatefulWidget {
  const _FriendSearchSheet();

  @override
  State<_FriendSearchSheet> createState() => _FriendSearchSheetState();
}

class _FriendSearchSheetState extends State<_FriendSearchSheet> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final controller = AppScope.of(context);
    final keyword = _query.trim().toLowerCase();
    final results = controller.friends
        .where((friend) => friend.name.toLowerCase().contains(keyword))
        .toList();

    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        20,
        20,
        20 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.person_add_alt_1_rounded,
                  size: 18, color: AppColors.primary),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Cari & Tambah Teman',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close_rounded, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            onChanged: (value) => setState(() => _query = value),
            decoration: const InputDecoration(
              hintText: 'Ketik nama (contoh: Budi, Siti, Andi)...',
              prefixIcon: Icon(Icons.search_rounded, size: 20),
            ),
          ),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 280),
            child: results.isEmpty
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: Text(
                        'Pengguna tidak ditemukan',
                        style: TextStyle(color: AppColors.textMuted, fontSize: 12),
                      ),
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    itemCount: results.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (_, index) => _FriendTile(
                      friend: results[index],
                      onAdd: () => AppScope.read(context)
                          .addFriend(results[index].id),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _FriendTile extends StatelessWidget {
  const _FriendTile({required this.friend, required this.onAdd});

  final Friend friend;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          UserAvatar(initial: friend.initial, size: 34),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              friend.name,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            ),
          ),
          if (friend.isFriend)
            const Text(
              'Berteman',
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            )
          else
            FilledButton(
              onPressed: onAdd,
              style: FilledButton.styleFrom(
                minimumSize: const Size(0, 32),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                textStyle: const TextStyle(fontSize: 11),
              ),
              child: const Text('+ Tambah'),
            ),
        ],
      ),
    );
  }
}
