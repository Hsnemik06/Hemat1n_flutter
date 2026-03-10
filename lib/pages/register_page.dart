//register.dart
import 'package:flutter/material.dart';
import '../style/register_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_page.dart';

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

    debugPrint("RegisterPage initialized");

    _animController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800));

    _fadeAnimation =
        CurvedAnimation(parent: _animController, curve: Curves.easeIn);

    _animController.forward();
  }

  @override
  void dispose() {
    debugPrint("RegisterPage disposed");

    _animController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();

    super.dispose();
  }

  Future<void> _registerUser() async {
    debugPrint("Tombol Sign Up ditekan");

    if (!_formKey.currentState!.validate()) {
      debugPrint("Form tidak valid");
      return;
    }

    debugPrint("Form valid, mulai register");

    try {

      debugPrint("Email: ${_emailController.text.trim()}");
      debugPrint("Mengirim data ke Firebase Auth");

      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      debugPrint("Register Firebase berhasil");

      User? user = userCredential.user;

      if (user != null) {
        debugPrint("User UID: ${user.uid}");
        debugPrint("Menyimpan data ke Firestore");

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set({
          'email': user.email,
          'created_at': Timestamp.now(),
        });

        debugPrint("Data berhasil disimpan di Firestore");
      }

      debugPrint("Logout user setelah register");

      await FirebaseAuth.instance.signOut();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Register berhasil")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      debugPrint("FirebaseAuthException terjadi");
      debugPrint("Error code: ${e.code}");
      debugPrint("Error message: ${e.message}");

      String message = "Register gagal";

      if (e.code == 'email-already-in-use') {
        message = "Email sudah digunakan";
      } else if (e.code == 'invalid-email') {
        message = "Format email salah";
      } else if (e.code == 'weak-password') {
        message = "Password terlalu lemah";
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );

    } catch (e) {

      debugPrint("Error tidak diketahui");
      debugPrint(e.toString());

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Terjadi kesalahan")),
      );
    }
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

                      // EMAIL
                      TextFormField(
                        controller: _emailController,
                        decoration: RegisterInputStyles.email,
                        validator: (value) {

                          debugPrint("Validasi email");

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

                      // PASSWORD
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_showPassword,
                        decoration: RegisterInputStyles.password.copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) {

                          debugPrint("Validasi password");

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

                      // CONFIRM PASSWORD
                      TextFormField(
                        controller: _confirmController,
                        obscureText: !_showConfirm,
                        decoration:
                            RegisterInputStyles.confirmPassword.copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _showConfirm
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _showConfirm = !_showConfirm;
                              });
                            },
                          ),
                        ),
                        validator: (value) {

                          debugPrint("Validasi confirm password");

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

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _registerUser,
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

                              debugPrint("User menekan Sign In");

                              Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation1, animation2) =>
                                      const LoginPage(),
                                  transitionsBuilder:
                                      (context, anim, anim2, child) {
                                    return FadeTransition(
                                        opacity: anim, child: child);
                                  },
                                  transitionDuration:
                                      const Duration(milliseconds: 500),
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
