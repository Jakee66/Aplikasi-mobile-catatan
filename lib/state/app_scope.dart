import 'package:flutter/widgets.dart';

import 'app_controller.dart';

/// Menyediakan [AppController] ke seluruh pohon widget.
class AppScope extends InheritedNotifier<AppController> {
  const AppScope({
    super.key,
    required AppController controller,
    required super.child,
  }) : super(notifier: controller);

  /// Dipakai di `build()`: widget akan rebuild saat state berubah.
  static AppController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope tidak ditemukan di atas widget ini.');
    return scope!.notifier!;
  }

  /// Dipakai di event handler (onPressed dsb.): tidak memicu rebuild.
  static AppController read(BuildContext context) {
    final scope = context.getInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope tidak ditemukan di atas widget ini.');
    return scope!.notifier!;
  }
}
