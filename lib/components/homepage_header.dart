import 'package:flutter/material.dart';
import '../style/homepage_style.dart';

class HomepageHeader extends StatelessWidget {
  const HomepageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: HomepageStyle.horizontalPadding,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: HomepageStyle.primaryGreen,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "assets/images/Hematin_Teks.png",
            height: 50,
          ),

          const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.black,
            child: Icon(Icons.person, color: Colors.white),
          ),
        ],
      ),
    );
  }
}