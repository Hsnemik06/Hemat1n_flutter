import 'package:flutter/material.dart';
import '../components/homepage_header.dart';
import '../components/homepage_body.dart';
import '../components/homepage_bottom_nav.dart';
import '../style/homepage_style.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HomepageStyle.backgroundGrey,

      body: Column(
        children: const [
          // Header boleh sampai atas layar
          HomepageHeader(),

          // Body tetap aman dari notch
          Expanded(
            child: SafeArea(
              top: false,
              child: HomepageBody(),
            ),
          ),
        ],
      ),

      bottomNavigationBar: const HomepageBottomNav(),
    );
  }
}