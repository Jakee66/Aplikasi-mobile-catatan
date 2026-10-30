import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../models/note.dart';

/// Warna badge untuk tiap kategori catatan.
extension NoteCategoryStyle on NoteCategory {
  Color get foreground => switch (this) {
        NoteCategory.kuliah => AppColors.primary,
        NoteCategory.tugas => const Color(0xFF059669),
        NoteCategory.pekerjaan => const Color(0xFFD97706),
        NoteCategory.pribadi => AppColors.accent,
      };

  Color get background => switch (this) {
        NoteCategory.kuliah => AppColors.primarySoft,
        NoteCategory.tugas => const Color(0xFFECFDF5),
        NoteCategory.pekerjaan => const Color(0xFFFFFBEB),
        NoteCategory.pribadi => const Color(0xFFF5F3FF),
      };
}
