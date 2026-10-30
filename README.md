# CatatAja (Flutter)

Aplikasi catatan pribadi & bersama. Versi ini **frontend saja** (data masih dummy di memori, belum ada back end).

## Cara menjalankan

Butuh Flutter terbaru (disarankan 3.35+).

```bash
cd catataja
flutter create . --project-name catataja   # membuat folder android/ios/dll (lib/ tidak ditimpa)
rm -f test/widget_test.dart                # bawaan flutter create, tidak dipakai
flutter pub get
flutter run
```

## Struktur folder

```
lib/
├── main.dart                  # entry point
├── app.dart                   # MaterialApp + AppScope
├── core/
│   ├── constants/             # teks & konstanta
│   ├── navigation/            # AppNavigator (semua perpindahan halaman)
│   ├── theme/                 # warna & tema
│   └── utils/                 # helper (format tanggal)
├── models/                    # Note, Friend
├── data/                      # data dummy
├── state/                     # AppController (ChangeNotifier) + AppScope
├── widgets/                   # widget yang dipakai ulang di banyak layar
└── screens/
    ├── splash/
    ├── onboarding/            # tutorial + kursor animasi
    ├── login/
    ├── home/                  # Catatan Pribadi / Bersama, cari, filter
    ├── add_note/              # form + undang kolaborator
    └── note_detail/           # detail + tambah anggota
```

## Alur layar

Splash → Tutorial (5 slide) → Login (statis) → Beranda → Tambah Catatan / Detail Catatan.

## Menghubungkan ke back end nanti

Semua data lewat `AppController`. Ganti isi method-nya (mis. panggil repository/API)
tanpa perlu mengubah layar.
