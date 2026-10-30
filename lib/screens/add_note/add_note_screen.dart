import 'package:flutter/material.dart';

import '../../models/note.dart';
import '../../state/app_scope.dart';
import '../../widgets/field_label.dart';
import '../../widgets/note_type_toggle.dart';
import 'widgets/collaborator_picker.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  NoteType _type = NoteType.personal;
  NoteCategory _category = NoteCategory.kuliah;
  final Set<String> _invited = {};

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _toggleInvite(String name) {
    setState(() {
      if (!_invited.remove(name)) _invited.add(name);
    });
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    AppScope.read(context).addNote(
      Note(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        category: _category,
        type: _type,
        date: DateTime.now(),
        collaborators: _type == NoteType.shared ? _invited.toList() : const [],
      ),
    );
    Navigator.of(context).pop(_type);
  }

  @override
  Widget build(BuildContext context) {
    final friends = AppScope.of(context).addedFriends;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Catatan Baru',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
        ),
        actions: [
          TextButton(
            onPressed: _save,
            child: const Text(
              'Simpan',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const FieldLabel('Tipe Catatan'),
            NoteTypeToggle(
              selected: _type,
              showIcons: false,
              onChanged: (type) => setState(() => _type = type),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              alignment: Alignment.topCenter,
              child: _type == NoteType.shared
                  ? Padding(
                      padding: const EdgeInsets.only(top: 14),
                      child: CollaboratorPicker(
                        friends: friends,
                        selected: _invited,
                        onToggle: _toggleInvite,
                      ),
                    )
                  : const SizedBox(width: double.infinity),
            ),
            const SizedBox(height: 16),
            const FieldLabel('Judul Catatan'),
            TextFormField(
              controller: _titleController,
              textCapitalization: TextCapitalization.sentences,
              style: const TextStyle(fontWeight: FontWeight.w700),
              decoration: const InputDecoration(
                hintText: 'Masukkan judul catatan...',
              ),
              validator: _requiredValidator('Judul'),
            ),
            const SizedBox(height: 16),
            const FieldLabel('Kategori'),
            DropdownButtonFormField<NoteCategory>(
              initialValue: _category,
              items: [
                for (final category in NoteCategory.values)
                  DropdownMenuItem(value: category, child: Text(category.label)),
              ],
              onChanged: (value) {
                if (value != null) setState(() => _category = value);
              },
            ),
            const SizedBox(height: 16),
            const FieldLabel('Isi Catatan'),
            TextFormField(
              controller: _contentController,
              minLines: 6,
              maxLines: 10,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                hintText: 'Tulis catatan lengkap Anda di sini...',
              ),
              validator: _requiredValidator('Isi catatan'),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.save_outlined, size: 18),
              label: const Text('Simpan Catatan'),
            ),
          ],
        ),
      ),
    );
  }

  FormFieldValidator<String> _requiredValidator(String fieldName) {
    return (value) =>
        (value == null || value.trim().isEmpty) ? '$fieldName wajib diisi' : null;
  }
}
