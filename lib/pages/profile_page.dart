import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../style/profile_style.dart';
import 'login_page.dart';
import '../components/homepage_bottom_nav.dart'; // <- import bottom navbar

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final genderController = TextEditingController();
  final birthdayController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  // LOAD PROFILE
  Future<void> _loadProfile() async {
    if (user == null) return;

    emailController.text = user!.email ?? "";

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    if (doc.exists) {
      final data = doc.data()!;
      setState(() {
        usernameController.text = data["username"] ?? "";
        genderController.text = data["gender"] ?? "";
        birthdayController.text = data["birthday"] ?? "";
      });
    }
  }

  // SAVE PROFILE
  Future<void> _saveProfile(String username, String gender, String birthday) async {
    if (user == null) return;

    await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
      "username": username,
      "gender": gender,
      "birthday": birthday,
    });
  }

  // CONTACT US
  Future<void> contactUs() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@yourapp.com',
      query: 'subject=Contact Support',
    );

    await launchUrl(emailLaunchUri);
  }

  // EDIT PROFILE
  void onEditProfile() {
    final username = TextEditingController(text: usernameController.text);
    final gender = TextEditingController(text: genderController.text);
    final birthday = TextEditingController(text: birthdayController.text);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Profile"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: username,
                  decoration: const InputDecoration(labelText: "Username"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: emailController,
                  enabled: false,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: gender,
                  decoration: const InputDecoration(labelText: "Gender"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: birthday,
                  decoration: const InputDecoration(labelText: "Birthday"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                usernameController.text = username.text;
                genderController.text = gender.text;
                birthdayController.text = birthday.text;

                await _saveProfile(username.text, gender.text, birthday.text);

                if (!mounted) return;
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Profile berhasil disimpan")),
                );
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // LOGOUT
  void onLogout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (!mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final photoUrl = user?.photoURL;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.grey[200],

      // ✅ Bottom Navbar, highlight Profile (index 2)
      bottomNavigationBar: const HomepageBottomNav(currentIndex: 2),

      body: ProfileUI(
        photoUrl: photoUrl,
        usernameController: usernameController,
        emailController: emailController,
        genderController: genderController,
        birthdayController: birthdayController,
        onEditProfile: onEditProfile,
        onLogout: onLogout,
        onContactUs: contactUs,
      ),
    );
  }
}