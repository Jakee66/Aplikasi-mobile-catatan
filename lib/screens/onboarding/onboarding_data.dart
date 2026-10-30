import 'package:flutter/material.dart';

import 'onboarding_slide.dart';
import 'widgets/onboarding_previews.dart';

abstract final class OnboardingData {
  static final slides = <OnboardingSlide>[
    OnboardingSlide(
      title: '1. Selamat Datang di CatatAja',
      description:
          'Aplikasi pencatatan pribadi dan kelompok modern untuk tugas sekolah & kerjaan.',
      previewBuilder: (_, __, ___) => const WelcomePreview(),
    ),
    OnboardingSlide(
      title: '2. Catatan Pribadi vs Bersama',
      description:
          'Beralih dengan mudah antara catatan pribadi atau catatan kelompok bersama teman.',
      loopCursor: true,
      cursorSteps: const [
        CursorStep.target(TabsPreview.sharedTabId, 'Pilih tab "Bersama"'),
        CursorStep.target(TabsPreview.personalTabId, 'Pilih tab "Pribadi"'),
      ],
      // Langkah 0 = tab "Bersama" aktif, langkah 1 = tab "Pribadi" aktif.
      previewBuilder: (_, step, targetKey) => TabsPreview(
        isSharedActive: step == 0,
        targetKey: targetKey,
      ),
    ),
    OnboardingSlide(
      title: '3. Tambah Catatan & Undang Teman',
      description:
          'Klik tombol + untuk menambah catatan baru dan centang nama teman yang diundang.',
      cursorSteps: const [
        CursorStep.at(Alignment(-0.3, -0.2), 'Klik tombol Tambah (+)'),
        CursorStep.target(InvitePreview.addButtonId, 'Klik tombol Tambah (+)'),
      ],
      previewBuilder: (_, __, targetKey) => InvitePreview(targetKey: targetKey),
    ),
    OnboardingSlide(
      title: '4. Cari & Tambah Teman',
      description:
          'Cari temanmu lewat form pencarian nama lalu klik tombol + Tambah.',
      cursorSteps: const [
        CursorStep.at(Alignment(-0.4, -0.6), 'Klik "+ Tambah" pada teman'),
        CursorStep.target(FriendPreview.addButtonId, 'Klik "+ Tambah" pada teman'),
      ],
      previewBuilder: (_, __, targetKey) => FriendPreview(targetKey: targetKey),
    ),
    OnboardingSlide(
      title: '5. Kelola Anggota di Detail Catatan',
      description:
          'Meskipun catatan sudah disimpan, kamu tetap bisa menambah anggota baru kapan saja.',
      cursorSteps: const [
        CursorStep.at(Alignment(-0.4, 0.6), 'Klik "+ Tambah Anggota"'),
        CursorStep.target(MemberPreview.addButtonId, 'Klik "+ Tambah Anggota"'),
      ],
      previewBuilder: (_, __, targetKey) => MemberPreview(targetKey: targetKey),
    ),
  ];
}