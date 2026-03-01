import 'package:flutter/material.dart';

class LoginColors {
  static const background = Colors.white;
  static const accent = Color.fromARGB(255, 145, 214, 25);
}

class LoginTextStyles {
  static const title = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static const dividerText = TextStyle(
    color: Colors.grey,
  );
}

class LoginInputStyles {
  static InputDecoration emailDecoration = InputDecoration(
    hintText: "Email",
    filled: true,
    fillColor: Colors.grey.shade200,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide.none,
    ),
  );

  static InputDecoration passwordDecoration = InputDecoration(
    hintText: "Password",
    filled: true,
    fillColor: Colors.grey.shade200,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide.none,
    ),
  );
}

class LoginButtonStyles {
  static final signInButton = ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 145, 214, 25),
    padding: const EdgeInsets.symmetric(vertical: 15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  );
}

class LoginDecorations {
  static BoxDecoration googleButton = BoxDecoration(
    border: Border.all(color: Colors.grey.shade300),
    borderRadius: BorderRadius.circular(15),
  );

  static const BoxDecoration bottomAccent = BoxDecoration(
    color: Color.fromARGB(255, 145, 214, 25),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(10),   // lebih kotak, kecilkan radius
      topRight: Radius.circular(10),
    ),
  );
}
