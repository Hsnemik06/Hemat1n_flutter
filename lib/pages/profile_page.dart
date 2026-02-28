import 'package:flutter/material.dart';
import '../style/profile_style.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void onEditProfile() {
    print("Edit Profile Clicked");
  }

  void onLogout() {
    print("Logout Clicked");
    Navigator.pop(context); // kembali ke halaman sebelumnya
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // 🔥 penting
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.transparent, // transparan
        elevation: 0,
      ),
      body: ProfileUI(
        emailController: emailController,
        passwordController: passwordController,
        confirmPasswordController: confirmPasswordController,
        onEditProfile: onEditProfile,
        onLogout: onLogout,
      ),
    );
  }
}