import 'package:contact_diary_5pm_app/controllers/providers/theme_provider.dart';
import 'package:contact_diary_5pm_app/utils/app_themes.dart';
import 'package:contact_diary_5pm_app/views/screens/add_contact_page.dart';
import 'package:contact_diary_5pm_app/views/screens/counter_page.dart';
import 'package:contact_diary_5pm_app/views/screens/detail_page.dart';
import 'package:contact_diary_5pm_app/views/screens/hidden_contact_page.dart';
import 'package:contact_diary_5pm_app/views/screens/home_page.dart';
import 'package:contact_diary_5pm_app/views/screens/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/providers/counter_provider.dart';
import 'models/theme_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool isIntroVisited =
      prefs.getBool('isIntroVisited') ?? false; // bool or null

  bool isDarkTheme = prefs.getBool('isDark') ?? false; // true or false

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CounterProvider()),
        ChangeNotifierProvider(
            create: (context) =>
                ThemeProvider(themeModel: ThemeModel(isDark: isDarkTheme))),
      ],
      builder: (context, _) {
        return MaterialApp(
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode:
              (Provider.of<ThemeProvider>(context).themeModel.isDark == false)
                  ? ThemeMode.light
                  : ThemeMode.dark,
          debugShowCheckedModeBanner: false,
          initialRoute: (isIntroVisited) ? '/' : 'intro_screen',
          routes: {
            'add_contact_page': (context) => AddContactPage(),
            'hidden_contact_page': (context) => HiddenContactPage(),
            'detail_page': (context) => DetailPage(),
            'counter_page': (context) => CounterPage(),
            'intro_screen': (context) => IntroScreen(),
            '/': (context) => HomePage(),
          },
        );
      },
    ),
  );
}
