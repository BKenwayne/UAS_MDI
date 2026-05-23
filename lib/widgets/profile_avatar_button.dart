import 'dart:convert';

import 'package:flutter/material.dart';

import '../data/local_storage_service.dart';
import '../pages/main_navigation_page.dart';

class ProfileAvatarButton extends StatelessWidget {
  final double radius;
  final double borderWidth;

  const ProfileAvatarButton({
    super.key,
    this.radius = 18,
    this.borderWidth = 1.8,
  });

  ImageProvider _getAvatarProvider(String? avatarBase64) {
    if (avatarBase64 != null && avatarBase64.isNotEmpty) {
      try {
        return MemoryImage(base64Decode(avatarBase64));
      } catch (_) {
        return const AssetImage('assets/images/logo.png');
      }
    }
    return const AssetImage('assets/images/logo.png');
  }

  @override
  Widget build(BuildContext context) {
    const brandGreen = Color(0xFF28542A);

    return ListenableBuilder(
      listenable: LocalStorageService.instance,
      builder: (context, _) {
        final avatarBase64 = LocalStorageService.instance.getCurrentUser()?.avatarBase64;

        return GestureDetector(
          onTap: () {
            context.findAncestorStateOfType<MainNavigationPageState>()?.setSelectedIndex(3);
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: brandGreen,
                width: borderWidth,
              ),
            ),
            child: CircleAvatar(
              key: ValueKey(avatarBase64 ?? 'default'),
              radius: radius,
              backgroundImage: _getAvatarProvider(avatarBase64),
            ),
          ),
        );
      },
    );
  }
}
