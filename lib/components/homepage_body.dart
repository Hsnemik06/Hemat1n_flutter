import 'package:flutter/material.dart';
import '../style/homepage_style.dart';

class HomepageBody extends StatelessWidget {
  const HomepageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: HomepageStyle.horizontalPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 5),

            /// ROOM TITLE
            const Text(
              "Room",
              style: HomepageStyle.sectionTitle,
            ),

            const SizedBox(height: 5),

            /// ROOM BUTTON CENTERED
            Container(
              width: 60,
              height: 35,
              decoration: BoxDecoration(
                color: HomepageStyle.primaryGreen,
                borderRadius: BorderRadius.circular(15),
                boxShadow: HomepageStyle.cardShadow,
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 28,
              ),
            ),

            const SizedBox(height: 40),

            /// DEVICE TITLE
            const Text(
              "Device",
              style: HomepageStyle.sectionTitle,
            ),

            const SizedBox(height: 10),

            /// DEVICE CARD CENTERED
            Align(
  alignment: Alignment.centerLeft,
  child: Container(
    width: 180,
    height: 240,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: HomepageStyle.cardRadius,
      boxShadow: HomepageStyle.cardShadow,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 45,
          height: 45,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: HomepageStyle.primaryGreen,
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          "Add device",
          style: HomepageStyle.deviceText,
        ),
      ],
    ),
  ),
),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}