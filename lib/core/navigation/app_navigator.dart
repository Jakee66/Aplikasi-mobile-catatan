import 'package:flutter/material.dart';

import '../../models/note.dart';
import '../../screens/add_note/add_note_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/login/login_screen.dart';
import '../../screens/note_detail/note_detail_screen.dart';
import '../../screens/onboarding/onboarding_screen.dart';

/// Satu pintu untuk semua perpindahan halaman.
abstract final class AppNavigator {
  static void toOnboarding(BuildContext context) =>
      _replace(context, const OnboardingScreen());

  static void toLogin(BuildContext context) =>
      _replace(context, const LoginScreen());

  static void toHome(BuildContext context) =>
      _replace(context, const HomeScreen());

  /// Mengembalikan tipe catatan yang disimpan, atau `null` jika dibatalkan.
  static Future<NoteType?> toAddNote(BuildContext context) =>
      _push<NoteType>(context, const AddNoteScreen());

  static Future<void> toNoteDetail(BuildContext context, String noteId) =>
      _push<void>(context, NoteDetailScreen(noteId: noteId));

  static Future<T?> _push<T>(BuildContext context, Widget page) {
    return Navigator.of(context).push<T>(
      MaterialPageRoute<T>(builder: (_) => page),
    );
  }

  static void _replace(BuildContext context, Widget page) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}
