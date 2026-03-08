//login_page.dart
import 'package:flutter/material.dart';
import '../style/login_style.dart';
import 'register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _showPassword = false;
  final _formKey = GlobalKey<FormState>();

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: LoginColors.background),
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
                        "Login to your Account",
                        style: LoginTextStyles.title,
                      ),
                      const SizedBox(height: 30),

                      // Email
                      TextFormField(
                        controller: _emailController,
                        decoration: LoginInputStyles.emailDecoration,
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
                        decoration: LoginInputStyles.passwordDecoration.copyWith(
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
                      const SizedBox(height: 30),

                      // Sign In Button (Email/Password)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              AuthService.loginWithEmail(
                                context,
                                _emailController.text.trim(),
                                _passwordController.text.trim(),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Login berhasil")),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: LoginColors.accent,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text("Sign In"),
                        ),
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        "~ Or sign in with ~",
                        style: LoginTextStyles.dividerText,
                      ),
                      const SizedBox(height: 15),

                      // Google Sign-In Button
                      GestureDetector(
                        onTap: () async {
                          await AuthService.signInWithGoogle(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: LoginDecorations.googleButton,
                          child: Image.asset(
                            'assets/images/G.png',
                            width: 30,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Sign Up navigation
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an Account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, anim1, anim2) =>
                                      const RegisterPage(),
                                  transitionsBuilder: (context, anim, anim2, child) {
                                    return FadeTransition(opacity: anim, child: child);
                                  },
                                  transitionDuration: const Duration(milliseconds: 500),
                                ),
                              );
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                color: LoginColors.accent,
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
              decoration: LoginDecorations.bottomAccent,
            ),
          ),
        ],
      ),
    );
  }
}

            // ======================
            // AuthService
            // ======================
                class AuthService {

            // =========================
            // LOGIN EMAIL & PASSWORD
            // =========================
                  static Future<void> loginWithEmail(
              BuildContext context, String email, String password) async {

            try {
              await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: email,
                password: password,
              );

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Login berhasil")),
                );
              }

            } on FirebaseAuthException catch (e) {
              String message = "Login gagal";

              if (e.code == 'user-not-found') {
                message = "User tidak ditemukan";
              } else if (e.code == 'wrong-password') {
                message = "Password salah";
              }

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message)),
                );
              }
            }
          }
                  // =========================
                  // GOOGLE SIGN IN
                  // =========================
                  static Future<void> signInWithGoogle(BuildContext context) async {
                    try {
                      final GoogleSignInAccount? googleUser =
                          await GoogleSignIn().signIn();

                      if (googleUser == null) return;

                      final googleAuth = await googleUser.authentication;

                      final credential = GoogleAuthProvider.credential(
                        accessToken: googleAuth.accessToken,
                        idToken: googleAuth.idToken,
                      );

                      await FirebaseAuth.instance.signInWithCredential(credential);

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Login Google berhasil")),
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const HomePage()),
                        );
                      }
                    } on FirebaseAuthException catch (e) {
                      String message = "Login Google gagal";

                      if (e.code == 'account-exists-with-different-credential') {
                        message = "Email sudah digunakan dengan metode lain";
                      }

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(message)),
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Terjadi kesalahan saat login")),
                        );
                      }
                    }
                  }
                }