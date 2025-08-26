import 'package:flutter/material.dart';
import 'package:news/ui/utils/app_assets.dart';

class ThemeProvider extends ChangeNotifier {
  var themeMode = ThemeMode.dark;

  String get splash => themeMode == ThemeMode.light
      ? AppAssets.splashLight
      : AppAssets.splashDark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void changeTheme(ThemeMode newMode) {
    themeMode = newMode;
    notifyListeners();
  }
}
