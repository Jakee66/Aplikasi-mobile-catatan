import 'dart:collection';

import 'package:flutter/foundation.dart';

import '../data/dummy_data.dart';
import '../models/friend.dart';
import '../models/note.dart';

/// Menyimpan seluruh state aplikasi (catatan & teman) di memori.
///
/// Nantinya kelas ini bisa diganti/dihubungkan ke repository back end
/// tanpa mengubah UI.
class AppController extends ChangeNotifier {
  AppController({List<Note>? notes, List<Friend>? friends})
      : _notes = List.of(notes ?? DummyData.notes),
        _friends = List.of(friends ?? DummyData.friends);

  final List<Note> _notes;
  final List<Friend> _friends;

  UnmodifiableListView<Note> get notes => UnmodifiableListView(_notes);
  UnmodifiableListView<Friend> get friends => UnmodifiableListView(_friends);

  /// Teman yang sudah ditambahkan (bisa diundang ke catatan bersama).
  List<Friend> get addedFriends =>
      _friends.where((friend) => friend.isFriend).toList();

  Note? noteById(String id) {
    for (final note in _notes) {
      if (note.id == id) return note;
    }
    return null;
  }

  List<Note> filterNotes({
    required NoteType type,
    NoteCategory? category,
    String query = '',
  }) {
    final keyword = query.trim().toLowerCase();
    return _notes.where((note) {
      final matchesType = note.type == type;
      final matchesCategory = category == null || note.category == category;
      final matchesQuery = keyword.isEmpty ||
          note.title.toLowerCase().contains(keyword) ||
          note.content.toLowerCase().contains(keyword);
      return matchesType && matchesCategory && matchesQuery;
    }).toList();
  }

  void addNote(Note note) {
    _notes.insert(0, note);
    notifyListeners();
  }

  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }

  void addCollaborator(String noteId, String name) {
    final index = _notes.indexWhere((note) => note.id == noteId);
    if (index == -1) return;

    final note = _notes[index];
    if (note.collaborators.contains(name)) return;

    _notes[index] = note.copyWith(collaborators: [...note.collaborators, name]);
    notifyListeners();
  }

  void addFriend(String friendId) {
    final index = _friends.indexWhere((friend) => friend.id == friendId);
    if (index == -1) return;

    _friends[index] = _friends[index].copyWith(isFriend: true);
    notifyListeners();
  }
}
