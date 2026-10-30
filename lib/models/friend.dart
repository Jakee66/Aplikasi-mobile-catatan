class Friend {
  const Friend({
    required this.id,
    required this.name,
    this.isFriend = false,
  });

  final String id;
  final String name;

  /// `true` jika sudah ditambahkan sebagai teman.
  final bool isFriend;

  String get initial => name.isEmpty ? '?' : name[0].toUpperCase();

  Friend copyWith({bool? isFriend}) {
    return Friend(id: id, name: name, isFriend: isFriend ?? this.isFriend);
  }
}
