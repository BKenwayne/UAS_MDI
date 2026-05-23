import 'package:flutter/material.dart';

import '../data/local_storage_service.dart';

/// Dengarkan perubahan profil (avatar, progress kuis, lencana, dll.) dari SQLite.
mixin ProfileListenerMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    LocalStorageService.instance.addListener(_onProfileChanged);
  }

  @override
  void dispose() {
    LocalStorageService.instance.removeListener(_onProfileChanged);
    super.dispose();
  }

  void onProfileChanged();

  void _onProfileChanged() {
    if (mounted) {
      onProfileChanged();
    }
  }
}
