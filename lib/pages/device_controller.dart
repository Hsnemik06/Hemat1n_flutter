import 'package:flutter/material.dart';
import '../style/homepage_style.dart';

class DeviceControllerPage extends StatelessWidget {

  final String deviceName;

  const DeviceControllerPage({
    super.key,
    required this.deviceName,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(deviceName),
        backgroundColor: HomepageStyle.primaryGreen,
      ),

      body: const Center(
        child: Text(
          "Device Controller",
          style: TextStyle(fontSize: 20),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: "Chart",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),

        ],
      ),
    );
  }
}