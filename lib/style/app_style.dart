import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color.fromARGB(255, 145, 214, 25);
  static const secondary = Color.fromARGB(255, 89, 192, 25);
  static const white = Colors.white;
  static const grey = Colors.grey;
}

class AppTextStyles {
  static const title = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static const link = TextStyle(
    color: AppColors.secondary,
    fontWeight: FontWeight.bold,
  );
}

class AppButtonStyles {
  static final primaryButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.secondary,
    foregroundColor: Colors.white,
    minimumSize: const Size(double.infinity, 50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );
}

class AppDecorations {
  static const BoxDecoration backgroundGradient = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xFF87ED75),
        Color(0xFF8BC62C),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );
}

