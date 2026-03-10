// usage_chart.dart
import 'package:flutter/material.dart';

class UsageChart extends StatelessWidget {
  const UsageChart({super.key});

  @override
  Widget build(BuildContext context) {
    // Contoh sederhana placeholder chart
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(
          child: Text(
            "Chart Placeholder",
            style: TextStyle(color: Colors.blue, fontSize: 18),
          ),
        ),
      ),
    );
  }
}