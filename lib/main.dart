import 'package:flutter/material.dart';
import 'package:studdy_bestie/resources/auth_methods.dart';
import 'package:studdy_bestie/screens/auth_Screen.dart';
import 'package:studdy_bestie/screens/home_screen.dart';
import 'package:studdy_bestie/screens/landing_screen.dart';
import 'package:studdy_bestie/screens/login_screen.dart';
import 'package:studdy_bestie/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        title: 'StudyBuddy',
        home: const AuthScreen());
  }
}
