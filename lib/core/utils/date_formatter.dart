abstract final class DateFormatter {
  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
    'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
  ];

  /// Contoh: `28 Okt 2026`.
  static String short(DateTime date) {
    return '${date.day} ${_months[date.month - 1]} ${date.year}';
  }

  /// Menampilkan "Hari Ini" jika tanggalnya hari ini, selain itu format pendek.
  static String relative(DateTime date, {DateTime? now}) {
    final today = now ?? DateTime.now();
    final isToday = date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;
    return isToday ? 'Hari Ini' : short(date);
  }
}
