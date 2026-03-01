import 'package:flutter/material.dart';

class HomepageStyle {

  // ===== COLORS =====
  static const Color primaryGreen = Color.fromARGB(255, 145, 214, 25);
  static const Color darkGreenText = Color.fromARGB(255, 101, 193, 21);
  static const Color backgroundGrey = Color(0xFFF5F5F5);

  // ===== SPACING =====
  static const double horizontalPadding = 20;

  // ===== TEXT =====
  static const TextStyle sectionTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle deviceText = TextStyle(
    fontSize: 16,
  );

  // ===== RADIUS =====
  static BorderRadius cardRadius = BorderRadius.circular(25);

  // ===== SHADOW =====
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black26,
      blurRadius: 20,
      offset: Offset(0, 10),
    )
  ];
}