import 'package:flutter/material.dart';

class NoteSearchField extends StatelessWidget {
  const NoteSearchField({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: const InputDecoration(
        hintText: 'Cari judul atau isi catatan...',
        prefixIcon: Icon(Icons.search_rounded, size: 20),
      ),
    );
  }
}
