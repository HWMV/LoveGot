import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.pink[400],
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.pink,
        secondary: Colors.purple[200],
      ),
      // 커스텀 테마 설정
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
