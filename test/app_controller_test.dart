import 'package:catataja/models/note.dart';
import 'package:catataja/state/app_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppController', () {
    late AppController controller;

    setUp(() => controller = AppController());
    tearDown(() => controller.dispose());

    test('memfilter catatan berdasarkan tipe', () {
      final personal = controller.filterNotes(type: NoteType.personal);
      final shared = controller.filterNotes(type: NoteType.shared);

      expect(personal.every((n) => n.type == NoteType.personal), isTrue);
      expect(shared.every((n) => n.type == NoteType.shared), isTrue);
    });

    test('memfilter berdasarkan kata kunci', () {
      final result = controller.filterNotes(
        type: NoteType.shared,
        query: 'sprint',
      );
      expect(result, hasLength(1));
    });

    test('menambah kolaborator tanpa duplikat', () {
      final note = controller.filterNotes(type: NoteType.shared).first;
      final before = note.collaborators.length;

      controller.addCollaborator(note.id, 'Maya Putri');
      controller.addCollaborator(note.id, 'Maya Putri');

      expect(controller.noteById(note.id)!.collaborators.length, before + 1);
    });

    test('menghapus catatan', () {
      final note = controller.notes.first;
      controller.deleteNote(note.id);
      expect(controller.noteById(note.id), isNull);
    });
  });
}
