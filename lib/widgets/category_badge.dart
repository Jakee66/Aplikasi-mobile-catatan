import 'package:flutter/material.dart';

import '../models/note.dart';
import 'category_style.dart';

class CategoryBadge extends StatelessWidget {
  const CategoryBadge({super.key, required this.category});

  final NoteCategory category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: category.background,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: category.foreground.withValues(alpha: 0.25),
        ),
      ),
      child: Text(
        category.label.toUpperCase(),
        style: TextStyle(
          color: category.foreground,
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}
