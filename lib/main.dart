import 'package:eduvault/Components/Images(StartingPages).dart';
import 'package:eduvault/Home.dart';
import 'package:eduvault/Login/Login.dart';
import 'package:eduvault/Login/Registration.dart';
import 'package:eduvault/OneTimeIntro.dart';
import 'package:eduvault/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final prefs = await SharedPreferences.getInstance();
  final bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  final bool isLoggedIn = FirebaseAuth.instance.currentUser != null;
  runApp(MyApp(isFirstTime: isFirstTime, isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;
  final bool isLoggedIn;
  const MyApp({super.key, required this.isFirstTime, required this.isLoggedIn});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF7FAFF), // Your default color
          foregroundColor: Colors.black,      // Default text/icon color
        ),
      ),
      home: isFirstTime ? const Startpage() : isLoggedIn ? const Home() : const Login(),
    );
  }


}


