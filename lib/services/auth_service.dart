import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// 🔐 Login dengan Google
Future<User?> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

  if (googleUser == null) return null;

  final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

  if (googleAuth.idToken == null) {
    throw Exception("ID Token Google tidak tersedia");
  }

  final credential = GoogleAuthProvider.credential(
  accessToken: googleAuth.accessToken, // biarkan nullable
  idToken: googleAuth.idToken!,        // non-nullable
);

  UserCredential userCredential =
      await _auth.signInWithCredential(credential);

  // Ambil Firebase ID Token
  String? idToken = await userCredential.user!.getIdToken();
if (idToken == null) {
  throw Exception("Gagal mendapatkan ID Token Firebase");
}
await _sendTokenToLaravel(idToken);


  // Kirim ke Laravel
  await _sendTokenToLaravel(idToken);

  return userCredential.user;
}


  /// 🌐 Kirim token ke Laravel
  Future<void> _sendTokenToLaravel(String token) async {
    final response = await http.post(
      Uri.parse("https://hemat1n-production.up.railway.app/api/login-google"),
      headers: {"Content-Type": "application/json",},
      body: jsonEncode({"token": token,}),
    );

    if (response.statusCode != 200) {
      throw Exception("Gagal login ke backend");
    }
  }
}
