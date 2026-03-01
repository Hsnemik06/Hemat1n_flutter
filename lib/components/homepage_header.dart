import 'package:flutter/material.dart';
import '../style/homepage_style.dart';

class HomepageHeader extends StatelessWidget {
  const HomepageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: HomepageStyle.primaryGreen,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: statusBarHeight * 0.8, // 🔥 lebih pendek dari default
          left: HomepageStyle.horizontalPadding,
          right: HomepageStyle.horizontalPadding,
          bottom: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/images/Hem_Log.png",
              height: 50, // tetap besar
            ),
            const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.black,
              child: Icon(Icons.person, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}