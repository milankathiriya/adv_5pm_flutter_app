import 'package:contact_diary_5pm_app/models/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeModel themeModel;

  ThemeProvider({
    required this.themeModel,
  });

  changeTheme() async {
    themeModel.isDark = !themeModel.isDark;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isDark', themeModel.isDark);

    notifyListeners();
  }
}
