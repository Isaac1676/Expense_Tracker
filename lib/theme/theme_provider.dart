import 'package:expense_tracker/theme/theme_mode.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toogleTheme() {
    if (_themeData == lightMode) {
      _themeData = darkMode;
    } else {
      _themeData = lightMode;
    }
    notifyListeners();
  }

  Widget icon() {
    if (_themeData == lightMode) {
      return const Icon(Icons.dark_mode_rounded);
    } else {
      return const Icon(Icons.light_mode_rounded);
    }
  }
}
