import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeModePreference {
  light,
  dark,
}

class PreferencesService {
  static const String _themeModeKey = 'themeMode';

  Future<ThemeModePreference> getThemeMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? themeModeIndex = prefs.getInt(_themeModeKey);
    return ThemeModePreference.values[themeModeIndex ?? 0];
  }

  Future<void> setThemeMode(ThemeModePreference themeMode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, themeMode.index);
  }
}
