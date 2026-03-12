//home_page.dart
import 'package:flutter/material.dart';
import '../homepage/homepage_header.dart';
import '../homepage/homepage_body.dart';
import '../homepage/homepage_bottom_nav.dart';
import '../style/homepage_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String> devices = [];

  void addDevice(String name) {
    setState(() {
      devices.add(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HomepageStyle.backgroundGrey,

      body: Column(
        children: [
          const HomepageHeader(),

          Expanded(
            child: SafeArea(
              top: false,
              child: HomepageBody(
                devices: devices,
                onAddDevice: addDevice,
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: const HomepageBottomNav(currentIndex: 0),
    );
  }
}