import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../models/note.dart';
import '../../state/app_scope.dart';
import '../../widgets/add_member_sheet.dart';
import '../../widgets/category_badge.dart';
import 'widgets/members_panel.dart';

class NoteDetailScreen extends StatelessWidget {
  const NoteDetailScreen({super.key, required this.noteId});

  final String noteId;

  Future<void> _confirmDelete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus catatan?'),
        content: const Text('Apakah Anda yakin ingin menghapus catatan ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      final controller = AppScope.read(context);
      Navigator.of(context).pop();
      controller.deleteNote(noteId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final note = AppScope.of(context).noteById(noteId);
    // Catatan sudah dihapus: tidak ada yang ditampilkan selama transisi keluar.
    if (note == null) return const Scaffold();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Catatan',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            onPressed: () => _confirmDelete(context),
            tooltip: 'Hapus catatan',
            icon: const Icon(Icons.delete_outline_rounded),
            color: AppColors.danger,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CategoryBadge(category: note.category),
              _TypeBadge(type: note.type),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            note.title,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              height: 1.3,
            ),
          ),
          if (note.isShared) ...[
            const SizedBox(height: 14),
            MembersPanel(
              collaborators: note.collaborators,
              onAddMember: () => showAddMemberSheet(context, noteId: note.id),
            ),
          ],
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(height: 1, color: AppColors.border),
          ),
          Text(
            note.content,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              height: 1.6,
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Kembali ke Beranda'),
          ),
        ),
      ),
    );
  }
}

class _TypeBadge extends StatelessWidget {
  const _TypeBadge({required this.type});

  final NoteType type;

  @override
  Widget build(BuildContext context) {
    final isShared = type == NoteType.shared;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isShared ? const Color(0xFFEDE9FE) : AppColors.divider,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        type.badge.toUpperCase(),
        style: TextStyle(
          color: isShared ? const Color(0xFF6D28D9) : AppColors.textSecondary,
          fontSize: 10,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
