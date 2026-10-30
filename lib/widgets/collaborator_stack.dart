import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';
import 'user_avatar.dart';

/// Avatar pemilik + kolaborator yang saling menumpuk.
class CollaboratorStack extends StatelessWidget {
  const CollaboratorStack({
    super.key,
    required this.collaborators,
    this.size = 22,
  });

  final List<String> collaborators;
  final double size;

  @override
  Widget build(BuildContext context) {
    final overlap = size * 0.7;
    final total = collaborators.length + 1;

    return SizedBox(
      width: size + (total - 1) * overlap,
      height: size,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: UserAvatar(
              initial: AppConstants.ownerInitial,
              size: size,
              isOwner: true,
              ringColor: AppColors.surface,
            ),
          ),
          for (var i = 0; i < collaborators.length; i++)
            Positioned(
              left: (i + 1) * overlap,
              child: UserAvatar(
                initial: collaborators[i][0].toUpperCase(),
                size: size,
                ringColor: AppColors.surface,
              ),
            ),
        ],
      ),
    );
  }
}
