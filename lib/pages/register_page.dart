import 'package:flutter/material.dart';
import '../style/register_style.dart';
import 'login_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _showPassword = false;
  bool _showConfirm = false;

  final _formKey = GlobalKey<FormState>();

  // Animasi Fade
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnimation = CurvedAnimation(parent: _animController, curve: Curves.easeIn);

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: RegisterColors.background),
          FadeTransition(
            opacity: _fadeAnimation,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 80),
                      Image.asset(
                        'assets/images/Hematin.png',
                        width: 120,
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "Create your Account",
                        style: RegisterTextStyles.title,
                      ),
                      const SizedBox(height: 30),

                      // Email
                      TextFormField(
                        controller: _emailController,
                        decoration: RegisterInputStyles.email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email tidak boleh kosong";
                          }
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return "Format email salah";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Password
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_showPassword,
                        decoration: RegisterInputStyles.password.copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _showPassword ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password tidak boleh kosong";
                          }
                          if (value.length < 6) {
                            return "Password minimal 6 karakter";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Confirm Password
                      TextFormField(
                        controller: _confirmController,
                        obscureText: !_showConfirm,
                        decoration: RegisterInputStyles.confirmPassword.copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _showConfirm ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _showConfirm = !_showConfirm;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Confirm password tidak boleh kosong";
                          }
                          if (value != _passwordController.text) {
                            return "Password tidak sama";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 30),

                      // Sign Up Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          final response = await http.post(
                            Uri.parse("https://hemat1n-production.up.railway.app/api/register"),
                            headers: {"Content-Type": "application/json"},
                            body: jsonEncode({
                              "name": "User",
                              "email": _emailController.text,
                              "password": _passwordController.text,
                            }),
                          );

                          print('Status code: ${response.statusCode}');
                          print('Response body: ${response.body}');

                          if (response.statusCode == 200 || response.statusCode == 201) {
                            // pastikan body JSON valid
                            final data = jsonDecode(response.body);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(data["message"])),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => const LoginPage()),
                              );
                            }
                          } else {
                            // body bisa berupa HTML error, jadi jangan decode dulu
                            String message;
                            try {
                              final data = jsonDecode(response.body);
                              message = data["message"].toString();
                            } catch (_) {
                              message = "Terjadi kesalahan server";
                            }

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(message)),
                              );
                            }
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Terjadi error: $e")),
                            );
                          }
                        }
                      }
                    },
                          style: RegisterButtonStyles.signUpButton,
                          child: const Text("Sign Up"),
                        ),
                      ),

                      const SizedBox(height: 25),

                      const Text(
                        "~ Or sign up with ~",
                        style: RegisterTextStyles.dividerText,
                      ),

                      const SizedBox(height: 15),

                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: RegisterDecorations.googleButton,
                        child: Image.asset(
                          'assets/images/G.png',
                          width: 30,
                        ),
                      ),

                      const SizedBox(height: 25),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have Account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation1, animation2) =>
                                      const LoginPage(),
                                  transitionsBuilder: (context, anim, anim2, child) {
                                    return FadeTransition(opacity: anim, child: child);
                                  },
                                  transitionDuration: const Duration(milliseconds: 500),
                                ),
                              );
                            },
                            child: const Text(
                              "Sign in",
                              style: TextStyle(
                                color: RegisterColors.accent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60,
              decoration: RegisterDecorations.bottomAccent,
            ),
          ),
        ],
      ),
    );
  }
}
