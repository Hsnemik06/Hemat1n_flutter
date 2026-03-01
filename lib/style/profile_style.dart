// profile_style.dart
import 'package:flutter/material.dart';

class ProfileUI extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController genderController;
  final TextEditingController birthdayController;
  final VoidCallback onEditProfile;
  final VoidCallback onLogout;

  const ProfileUI({
    super.key,
    required this.usernameController,
    required this.emailController,
    required this.genderController,
    required this.birthdayController,
    required this.onEditProfile,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildHeader(),
        _buildContent(context),
      ],
    );
  }
Widget _buildHeader() {
  return Container(
    height: 250,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 145, 214, 25),
          Color.fromARGB(255, 101, 193, 21),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
    ),
  );
}
  Widget _buildContent(BuildContext context) {
  return SafeArea(
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        // Container putih
        Container(
          margin: const EdgeInsets.only(top: 70),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 80),

              // Scrollable field
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Profile User",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildTextField("Username", usernameController),
                      const SizedBox(height: 20),
                      _buildTextField("Email", emailController),
                      const SizedBox(height: 20),
                      _buildTextField("Gender", genderController),
                      const SizedBox(height: 20),
                      _buildTextField("Birthday", birthdayController),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              // Strip hitam + Contact Us pindah ke sini
              Container(
                height: 1,
                color: Colors.black54,
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () {
                  debugPrint("Contact Us clicked");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Contact Us",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
              const SizedBox(height: 50),

              // Buttons tetap di bawah layar
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B2F2F),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: onEditProfile,
                      icon: const Icon(Icons.edit),
                      label: const Text("Edit Profile"),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red, width: 2),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: onLogout,
                      icon: const Icon(Icons.logout, color: Colors.red),
                      label: const Text(
                        "Log out",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Logo (tidak tertutup)
        const CircleAvatar(
          radius: 55,
          backgroundColor: Color.fromARGB(255, 10, 13, 45),
          child: Icon(Icons.person, size: 60),
        ),
      ],
    ),
  );
}

  Widget _buildTextField(
    String hint,
    TextEditingController controller, {
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}