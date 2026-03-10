//main.dart

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'controllers/data_controller.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(

      providers: [

        // Controller IoT
        ChangeNotifierProvider(
          create: (_) => DataController(),
        ),

      ],

      child: MaterialApp(

        debugShowCheckedModeBanner: false,

        title: "Smart Power Monitor",

        theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.grey[200],
        ),

        home: const AuthWrapper(),

      ),

    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<User?>(

      stream: FirebaseAuth.instance.authStateChanges(),

      builder: (context, snapshot) {

        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {

          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );

        }

        // Error
        if (snapshot.hasError) {

          return const Scaffold(
            body: Center(
              child: Text("Something went wrong"),
            ),
          );

        }

        // Jika sudah login
        if (snapshot.hasData) {

          return const HomePage();

        }

        // Jika belum login
        return const LoginPage();

      },

    );
  }
}