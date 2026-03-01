// homepage_bottom_nav.dart
import 'package:flutter/material.dart';
import '../pages/profile_page.dart';

class HomepageBottomNav extends StatelessWidget {
  const HomepageBottomNav({super.key});

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
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const _NavItem(
            icon: Icons.home,
            isActive: true,
          ),
          const _NavItem(
            icon: Icons.description,
            isActive: false,
          ),

          // ✅ Profile Button
          _NavItem(
            icon: Icons.person,
            isActive: false,
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
          )
        ],
      ),
    );
  }
}