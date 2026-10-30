import 'package:flutter/material.dart';

import 'onboarding_slide.dart';
import 'widgets/onboarding_previews.dart';

abstract final class OnboardingData {
  static final slides = <OnboardingSlide>[
    OnboardingSlide(
      title: '1. Selamat Datang di CatatAja',
      description:
          'Aplikasi pencatatan pribadi dan kelompok modern untuk tugas sekolah & kerjaan.',
      previewBuilder: (_, __) => const WelcomePreview(),
    ),
    OnboardingSlide(
      title: '2. Catatan Pribadi vs Bersama',
      description:
          'Beralih dengan mudah antara catatan pribadi atau catatan kelompok bersama teman.',
      loopCursor: true,
      cursorSteps: const [
        CursorStep(Alignment(0.5, -0.78), 'Bersama'),
        CursorStep(Alignment(-0.5, -0.78), 'Pribadi'),
      ],
      // Langkah 0 = tab "Bersama" aktif, langkah 1 = tab "Pribadi" aktif.
      previewBuilder: (_, step) => TabsPreview(isSharedActive: step == 0),
    ),
    OnboardingSlide(
      title: '3. Tambah Catatan & Undang Teman',
      description:
          'Klik tombol + untuk menambah catatan baru dan centang nama teman yang diundang.',
      cursorSteps: const [
        CursorStep(Alignment(-0.3, -0.2), 'Klik Tombol Tambah (+)'),
        CursorStep(Alignment(0.85, 0.8), 'Klik Tombol Tambah (+)'),
      ],
      previewBuilder: (_, __) => const InvitePreview(),
    ),
    OnboardingSlide(
      title: '4. Cari & Tambah Teman',
      description:
          'Cari temanmu lewat form pencarian nama lalu klik tombol + Tambah.',
      cursorSteps: const [
        CursorStep(Alignment(-0.4, -0.6), 'Klik "+ Tambah" Teman'),
        CursorStep(Alignment(0.78, 0), 'Klik "+ Tambah" Teman'),
      ],
      previewBuilder: (_, __) => const FriendPreview(),
    ),
    OnboardingSlide(
      title: '5. Kelola Anggota di Detail Catatan',
      description:
          'Meskipun catatan sudah disimpan, kamu tetap bisa menambah anggota baru kapan saja.',
      cursorSteps: const [
        CursorStep(Alignment(-0.4, 0.5), 'Klik "+ Tambah Anggota"'),
        CursorStep(Alignment(0.72, -0.2), 'Klik "+ Tambah Anggota"'),
      ],
      previewBuilder: (_, __) => const MemberPreview(),
    ),
  ];
}
