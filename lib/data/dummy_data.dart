import '../models/friend.dart';
import '../models/note.dart';

/// Data contoh untuk prototipe (belum terhubung ke back end).
abstract final class DummyData {
  static const friends = <Friend>[
    Friend(id: 'f1', name: 'Budi Santoso', isFriend: true),
    Friend(id: 'f2', name: 'Siti Rahma', isFriend: true),
    Friend(id: 'f3', name: 'Andi Wijaya', isFriend: true),
    Friend(id: 'f4', name: 'Rian Prasetya'),
    Friend(id: 'f5', name: 'Maya Putri'),
  ];

  static final notes = <Note>[
    Note(
      id: 'n1',
      title: 'Jadwal & Tugas Pemrograman Mobile',
      content: 'Materi minggu ini melingkupi implementasi Widget Flutter, '
          'Navigation Route, State Management, serta perancangan UI/UX '
          'yang konsisten.',
      category: NoteCategory.kuliah,
      type: NoteType.personal,
      date: DateTime(2026, 10, 28),
    ),
    Note(
      id: 'n2',
      title: 'Proyek Kelompok Flutter UI/UX',
      content: 'Pembagian Tugas:\n'
          '- Budi: Splash & Login UI\n'
          '- Siti: Beranda & Detail Catatan\n'
          '- Saya: Form Catatan & Fitur Kolaborasi.',
      category: NoteCategory.tugas,
      type: NoteType.shared,
      date: DateTime(2026, 10, 28),
      collaborators: ['Budi Santoso', 'Siti Rahma'],
    ),
    Note(
      id: 'n3',
      title: 'Rencana Sprint Aplikasi CatatAja',
      content: 'Selesaikan pengerjaan 5 halaman UI Flutter:\n'
          '- Splash Screen\n'
          '- Tutorial Carousel\n'
          '- Login Screen dengan Google\n'
          '- Beranda & Form Catatan Bersama.',
      category: NoteCategory.pekerjaan,
      type: NoteType.shared,
      date: DateTime(2026, 10, 27),
      collaborators: ['Andi Wijaya'],
    ),
  ];
}
