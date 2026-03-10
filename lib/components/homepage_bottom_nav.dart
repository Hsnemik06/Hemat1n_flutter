// homepage_bottom_nav.dart
import 'package:flutter/material.dart';
import '../pages/profile_page.dart';
import '../pages/data_page.dart';

class HomepageBottomNav extends StatelessWidget {
  final int currentIndex; // 0 = Home, 1 = Data, 2 = Profile

  const HomepageBottomNav({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 145, 214, 25),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Home Button
          _NavItem(
            icon: Icons.home,
            isActive: currentIndex == 0,
            onTap: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),

          // Data Button
          _NavItem(
            icon: Icons.description,
            isActive: currentIndex == 1,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DataPage(),
                ),
              );
            },
          ),

          // Profile Button
          _NavItem(
            icon: Icons.person,
            isActive: currentIndex == 2,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback? onTap;

  const _NavItem({
    required this.icon,
    required this.isActive,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive
                ? const Color.fromARGB(255, 232, 251, 205)
                : Colors.grey,
            size: 28,
          ),
          const SizedBox(height: 5),
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: isActive
                  ? const Color.fromARGB(255, 239, 251, 205)
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  
  }
}