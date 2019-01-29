import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:event_bus/event_bus.dart';

class ThemeUtils {
  static const Color defaultColor = const Color(0xFF63CA6C);

  static const List<Color> supportColors = [
    defaultColor,
    Colors.black,
    Colors.purple,
    Colors.orange,
    Colors.deepPurpleAccent,
    Colors.redAccent,
    Colors.blue,
    Colors.amber,
    Colors.green,
    Colors.lime,
    Colors.indigo,
    Colors.cyan,
    Colors.teal
  ];

  static Color currentColorTheme = defaultColor;

  static final String spColorThemeIndex = "colorThemeIndex";

  static setColorTheme(int colorThemeIndex) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt(spColorThemeIndex, colorThemeIndex);
  }

  static Future<int> getColorThemeIndex() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getInt(spColorThemeIndex);
  }
}

class AppThemeConfig {
  static EventBus eventBus = new EventBus();
}

class ChangeThemeEvent {
  Color color;

  ChangeThemeEvent(Color c) {
    color = c;
  }
}

