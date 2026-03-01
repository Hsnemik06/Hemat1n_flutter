// profile_page.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../style/profile_style.dart';
import 'login_page.dart';

// Contoh service simpan data (sesuaikan dengan backend kamu)
Future<void> saveProfileToDatabase({
  required String username,
  required String gender,
  required String birthday,
}) async {
  // Panggil API backend kamu untuk update profile
  // Contoh pseudo-code:
  // await http.post(Uri.parse("https://api.example.com/updateProfile"),
  //     body: {"username": username, "gender": gender, "birthday": birthday});
  await Future.delayed(const Duration(seconds: 1)); // simulasi delay
  debugPrint("Data saved: $username | $gender | $birthday");
}

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

  // Field readonly awalnya
  bool _isEditable = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    // Ambil data dari database / API
    // Contoh statik:
    setState(() {
      usernameController.text = "Angel Cry";
      emailController.text = "angel@example.com"; // tidak bisa diedit
      genderController.text = "Male";
      birthdayController.text = "01-01-2000";
    });
  }

  void onEditProfile() {
    setState(() {
      _isEditable = true;
    });

    // Tampilkan popup untuk edit
    showDialog(
      context: context,
      builder: (_) {
        final editUsername = TextEditingController(text: usernameController.text);
        final editGender = TextEditingController(text: genderController.text);
        final editBirthday = TextEditingController(text: birthdayController.text);

        return AlertDialog(
          title: const Text("Edit Profile"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: editUsername,
                  decoration: const InputDecoration(labelText: "Username"),
                ),
                TextField(
                  controller: editGender,
                  decoration: const InputDecoration(labelText: "Gender"),
                ),
                TextField(
                  controller: editBirthday,
                  decoration: const InputDecoration(labelText: "Birthday"),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: "Email (tidak bisa diedit)"),
                  enabled: false,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () async {
                // Simpan ke controller
                setState(() {
                  usernameController.text = editUsername.text;
                  genderController.text = editGender.text;
                  birthdayController.text = editBirthday.text;
                });

                // Simpan ke database
                await saveProfileToDatabase(
                  username: editUsername.text,
                  gender: editGender.text,
                  birthday: editBirthday.text,
                );

                Navigator.pop(context); // tutup popup
                setState(() => _isEditable = false);
              },
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  void onLogout() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();

      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } catch (e) {
      debugPrint("Logout error: $e");
    }

    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    genderController.dispose();
    birthdayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ProfileUI(
        usernameController: usernameController,
        emailController: emailController,
        genderController: genderController,
        birthdayController: birthdayController,
        onEditProfile: onEditProfile,
        onLogout: onLogout,
      ),
    );
  }
}