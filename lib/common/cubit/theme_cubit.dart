import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  static const String themeKey = "theme_mode";

  // Toggle Theme and Save it
  void toggleTheme() async {
    final newTheme =
        state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(newTheme);
    await _saveTheme(newTheme);
  }

  // Set Theme Directly
  void setTheme(ThemeMode themeMode) async {
    emit(themeMode);
    await _saveTheme(themeMode);
  }

  // Save Theme Mode to SharedPreferences
  Future<void> _saveTheme(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(themeKey, themeMode.index);
  }

  // Load Theme Mode from SharedPreferences
  static Future<ThemeMode> getSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(themeKey);
    if (themeIndex != null) {
      return ThemeMode.values[themeIndex];
    }
    return ThemeMode.light;
  }
}
