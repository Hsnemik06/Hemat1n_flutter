import 'package:flutter/material.dart';

class ProfileUI extends StatelessWidget {

  final String? photoUrl;

  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController genderController;
  final TextEditingController birthdayController;

  final VoidCallback onEditProfile;
  final VoidCallback onLogout;
  final VoidCallback onContactUs;

  const ProfileUI({
    super.key,
    required this.photoUrl,
    required this.usernameController,
    required this.emailController,
    required this.genderController,
    required this.birthdayController,
    required this.onEditProfile,
    required this.onLogout,
    required this.onContactUs,
  });

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [

        _buildHeader(),

        _buildContent(context),

        Positioned(
          top: 80,
          left: 0,
          right: 0,
          child: Center(
            child: CircleAvatar(
              radius: 55,
              backgroundImage:
              photoUrl != null ? NetworkImage(photoUrl!) : null,
              child: photoUrl == null
                  ? const Icon(Icons.person, size: 50)
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {

    return Container(
      height: 220,

      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 145, 214, 25),
            Color.fromARGB(255, 101, 193, 21),
          ],
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

      child: Container(

        margin: const EdgeInsets.only(top: 75),

        padding: const EdgeInsets.all(20),

        decoration: const BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [

            const SizedBox(height: 12),

            _field("Username", usernameController),

            const SizedBox(height:20),

            _field("Email", emailController),

            const SizedBox(height:20),

            _field("Gender", genderController),

            const SizedBox(height:20),

            _field("Birthday", birthdayController),

            const SizedBox(height:20),

            // CONTACT US
            ListTile(
              leading: const Icon(Icons.support_agent),
              title: const Text("Contact Us"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: onContactUs,
            ),

            const Spacer(),

            Row(
              children: [

                Expanded(
                  child: ElevatedButton(
                    onPressed: onEditProfile,
                    child: const Text("Edit Profile"),
                  ),
                ),

                const SizedBox(width:10),

                Expanded(
                  child: OutlinedButton(
                    onPressed: onLogout,
                    child: const Text("Logout"),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController controller){

    return TextField(
      controller: controller,
      enabled: false,

      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}