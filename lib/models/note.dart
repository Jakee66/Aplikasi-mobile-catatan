enum NoteType {
  personal('Pribadi', 'Catatan Pribadi'),
  shared('Bersama', 'Catatan Bersama');

  const NoteType(this.badge, this.label);

  /// Label singkat untuk badge.
  final String badge;

  /// Label panjang untuk tab / tombol.
  final String label;
}

enum NoteCategory {
  kuliah('Kuliah'),
  tugas('Tugas'),
  pekerjaan('Pekerjaan'),
  pribadi('Pribadi');

  const NoteCategory(this.label);

  final String label;
}

class Note {
  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.type,
    required this.date,
    this.collaborators = const [],
  });

  final String id;
  final String title;
  final String content;
  final NoteCategory category;
  final NoteType type;
  final DateTime date;

  /// Nama anggota selain pemilik. Hanya terisi untuk catatan bersama.
  final List<String> collaborators;

  bool get isShared => type == NoteType.shared;

  /// Jumlah anggota termasuk pemilik.
  int get memberCount => collaborators.length + 1;

  Note copyWith({List<String>? collaborators}) {
    return Note(
      id: id,
      title: title,
      content: content,
      category: category,
      type: type,
      date: date,
      collaborators: collaborators ?? this.collaborators,
    );
  }
}
