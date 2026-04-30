import 'package:flutter/material.dart';

class CalculatorThemeData {
  final String name;
  final Color scaffoldBackgroundColor;
  final Color displayBackgroundColor;
  final Color displayTextColor;
  final Color keypadBackgroundColor;
  final Color buttonBackground;
  final Color buttonTextColor;
  final Color operatorBackground;
  final Color operatorTextColor;
  final Color actionBackground; // AC, DEL
  final Color actionTextColor;
  final Color functionBackground; // Scientific functions
  final Color functionTextColor;
  final Color borderColor;
  final Brightness brightness;

  const CalculatorThemeData({
    required this.name,
    required this.scaffoldBackgroundColor,
    required this.displayBackgroundColor,
    required this.displayTextColor,
    required this.keypadBackgroundColor,
    required this.buttonBackground,
    required this.buttonTextColor,
    required this.operatorBackground,
    required this.operatorTextColor,
    required this.actionBackground,
    required this.actionTextColor,
    required this.functionBackground,
    required this.functionTextColor,
    required this.borderColor,
    required this.brightness,
  });
}

class CalculatorThemes {
  static const CalculatorThemeData classic = CalculatorThemeData(
    name: 'Classic',
    scaffoldBackgroundColor: Color(0xFFE0E0E0), // Silver/Grey body
    displayBackgroundColor: Color(0xFFC4Dbb8), // LCD Greenish
    displayTextColor: Color(0xFF000000),
    keypadBackgroundColor: Color(0xFFE0E0E0),
    buttonBackground: Color(0xFFF5F5F5), // White/Grey keys
    buttonTextColor: Color(0xFF000000),
    operatorBackground: Color(0xFF424242), // Dark Grey operators
    operatorTextColor: Color(0xFFFFFFFF),
    actionBackground: Color(0xFFFF9800), // Orange AC/DEL
    actionTextColor: Color(0xFFFFFFFF),
    functionBackground: Color(0xFF616161), // Darker grey for functions
    functionTextColor: Color(0xFFFFFFFF),
    borderColor: Color(0xFF9E9E9E),
    brightness: Brightness.light,
  );

  static const CalculatorThemeData dark = CalculatorThemeData(
    name: 'Dark',
    scaffoldBackgroundColor: Color(0xFF1E1E1E),
    displayBackgroundColor: Color(0xFF2D2D2D),
    displayTextColor: Color(0xFFFFFFFF),
    keypadBackgroundColor: Color(0xFF1E1E1E),
    buttonBackground: Color(0xFF3D3D3D),
    buttonTextColor: Color(0xFFFFFFFF),
    operatorBackground: Color(0xFF4A90E2), // Blue operators
    operatorTextColor: Color(0xFFFFFFFF),
    actionBackground: Color(0xFFE94B3C), // Red AC/DEL
    actionTextColor: Color(0xFFFFFFFF),
    functionBackground: Color(0xFF424242),
    functionTextColor: Color(0xFFFFFFFF),
    borderColor: Color(0xFF000000),
    brightness: Brightness.dark,
  );

  static const CalculatorThemeData pink = CalculatorThemeData(
    name: 'Pink',
    scaffoldBackgroundColor: Color(0xFFFCE4EC), // Pink 50
    displayBackgroundColor: Color(0xFFF8BBD0), // Pink 100
    displayTextColor: Color(0xFF880E4F), // Pink 900
    keypadBackgroundColor: Color(0xFFFCE4EC),
    buttonBackground: Color(0xFFFFFFFF),
    buttonTextColor: Color(0xFF880E4F),
    operatorBackground: Color(0xFFEC407A), // Pink 400
    operatorTextColor: Color(0xFFFFFFFF),
    actionBackground: Color(0xFFD81B60), // Pink 600
    actionTextColor: Color(0xFFFFFFFF),
    functionBackground: Color(0xFFF48FB1), // Pink 200
    functionTextColor: Color(0xFF880E4F),
    borderColor: Color(0xFFF06292),
    brightness: Brightness.light,
  );

  static const CalculatorThemeData orange = CalculatorThemeData(
    name: 'Orange',
    scaffoldBackgroundColor: Color(0xFFFFF3E0), // Orange 50
    displayBackgroundColor: Color(0xFFFFCC80), // Orange 200
    displayTextColor: Color(0xFFE65100), // Orange 900
    keypadBackgroundColor: Color(0xFFFFF3E0),
    buttonBackground: Color(0xFFFFFFFF),
    buttonTextColor: Color(0xFFE65100),
    operatorBackground: Color(0xFFFF9800), // Orange 500
    operatorTextColor: Color(0xFFFFFFFF),
    actionBackground: Color(0xFFEF6C00), // Orange 800
    actionTextColor: Color(0xFFFFFFFF),
    functionBackground: Color(0xFFFFB74D), // Orange 300
    functionTextColor: Color(0xFFE65100),
    borderColor: Color(0xFFFF9800),
    brightness: Brightness.light,
  );

  static CalculatorThemeData getTheme(String name) {
    switch (name) {
      case 'Classic':
        return classic;
      case 'Dark':
        return dark;
      case 'Pink':
        return pink;
      case 'Orange':
        return orange;
      default:
        return classic;
    }
  }
}
