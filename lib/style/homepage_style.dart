import 'package:flutter/material.dart';

class HomepageStyle {

  // ===== COLORS =====
  static const Color primaryGreen = Color(0xFF38D45A);
  static const Color darkGreenText = Color(0xFF006D5B);
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