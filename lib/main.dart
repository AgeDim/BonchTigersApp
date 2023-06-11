import 'package:bonch_tigers_app/features/login/login_page.dart';
import 'package:bonch_tigers_app/features/main_page/main_page.dart';
import 'package:bonch_tigers_app/features/register/register_page.dart';
import 'package:bonch_tigers_app/features/start/register_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/mainPage',
      routes: {
        '/startPage': (context) => const StartPage(),
        '/loginPage': (context) => const LoginPage(),
        '/registerPage': (context) => const RegisterPage(),
        '/mainPage': (context) => const MainPage(),
      },
    ),
  );
}
