//device.dart
import 'package:flutter/material.dart';
import '../homepage/homepage_bottom_nav.dart';
import '../style/homepage_style.dart';

class DevicePage extends StatelessWidget {

  final String deviceName;

  const DevicePage({super.key, required this.deviceName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HomepageStyle.backgroundGrey,

      appBar: AppBar(
        title: Text(deviceName),
        backgroundColor: HomepageStyle.primaryGreen,
      ),

      body: const Center(
        child: Text("Device Control Page"),
      ),

      bottomNavigationBar: const HomepageBottomNav(currentIndex: 0),
    );
  }
}