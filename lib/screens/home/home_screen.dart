import 'package:flutter/material.dart';

import '../../core/navigation/app_navigator.dart';
import '../../core/theme/app_colors.dart';
import '../../models/note.dart';
import '../../state/app_scope.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/friend_search_sheet.dart';
import '../../widgets/note_card.dart';
import '../../widgets/note_type_toggle.dart';
import 'widgets/category_filter_bar.dart';
import 'widgets/home_header.dart';
import 'widgets/note_search_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NoteType _type = NoteType.personal;
  NoteCategory? _category; // null = semua kategori
  String _query = '';

  Future<void> _openAddNote() async {
    final savedType = await AppNavigator.toAddNote(context);
    if (savedType != null && mounted) {
      setState(() => _type = savedType);
    }
  }

  @override
  Widget build(BuildContext context) {
    final notes = AppScope.of(context).filterNotes(
      type: _type,
      category: _category,
      query: _query,
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HomeHeader(
              onFindFriends: () => showFriendSearchSheet(context),
              onLogout: () => AppNavigator.toLogin(context),
            ),
            Container(
              color: AppColors.surface,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: NoteTypeToggle(
                selected: _type,
                onChanged: (type) => setState(() => _type = type),
              ),
            ),
            const Divider(height: 1, color: AppColors.divider),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
              child: NoteSearchField(
                onChanged: (value) => setState(() => _query = value),
              ),
            ),
            CategoryFilterBar(
              selected: _category,
              onSelected: (category) => setState(() => _category = category),
            ),
            Expanded(
              child: notes.isEmpty
                  ? EmptyState(
                      title: 'Tidak ada catatan ${_type.badge.toLowerCase()}',
                      message: 'Klik tombol + di bawah untuk membuat catatan baru',
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
                      itemCount: notes.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (_, index) => NoteCard(
                        note: notes[index],
                        onTap: () =>
                            AppNavigator.toNoteDetail(context, notes[index].id),
                      ),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: _AddNoteFab(onPressed: _openAddNote),
    );
  }
}

class _AddNoteFab extends StatelessWidget {
  const _AddNoteFab({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.4),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(18),
          child: const SizedBox(
            width: 56,
            height: 56,
            child: Icon(Icons.add_rounded, color: Colors.white, size: 28),
          ),
        ),
      ),
    );
  }
}
