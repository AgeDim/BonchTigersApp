import 'package:bonch_tigers_app/features/login/login_page.dart';
import 'package:bonch_tigers_app/features/main_page/main_page.dart';
import 'package:bonch_tigers_app/features/register/register_page.dart';
import 'package:bonch_tigers_app/features/start/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: user == null ? '/loginPage' : '/mainPage',
      routes: {
        '/startPage': (context) => const StartPage(),
        '/loginPage': (context) => const LoginPage(),
        '/registerPage': (context) => const RegisterPage(),
        '/mainPage': (context) => const MainPage(),
      },
    );
  }
}
