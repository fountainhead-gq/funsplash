import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:event_bus/event_bus.dart';

class ThemeUtils {
  static const Color defaultColor = const Color(0xFF2d3e50);

  static const List<Color> supportColors = [
    defaultColor,
    Color(0xFF135546),
    Color(0xFFd3893d),
    Color(0xFFa1897c),
    Color(0xFF2d3b47),
    Color(0xFFb04523),
    Color(0xFFddad71),
    Color(0xFF81513e),
    Color(0xFF39515e),
    Color(0xFFb52323),
    Color(0xFF12612f),
    Color(0xFF93211c),
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

