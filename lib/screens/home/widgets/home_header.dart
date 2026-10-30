import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widgets/user_avatar.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.onFindFriends,
    required this.onLogout,
  });

  final VoidCallback onFindFriends;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
      child: Row(
        children: [
          const UserAvatar(
            initial: AppConstants.ownerInitial,
            size: 38,
            isOwner: true,
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppConstants.appName,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                ),
                Text(
                  'Halo, ${AppConstants.greetingName}!',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 11),
                ),
              ],
            ),
          ),
          TextButton.icon(
            onPressed: onFindFriends,
            style: TextButton.styleFrom(
              backgroundColor: AppColors.primarySoft,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            icon: const Icon(Icons.person_add_alt_1_rounded, size: 16),
            label: const Text(
              'Cari Teman',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
            ),
          ),
          IconButton(
            onPressed: onLogout,
            tooltip: 'Keluar',
            icon: const Icon(Icons.logout_rounded, size: 20),
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }
}
