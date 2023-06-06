import 'package:bonch_tigers_app/features/login/LoginPage.dart';
import 'package:bonch_tigers_app/features/register/RegisterPage.dart';
import 'package:bonch_tigers_app/features/start/StartPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/startPage',
      routes: {
        '/startPage': (context) => const StartPage(),
        '/loginPage': (context) => const LoginPage(),
        '/registerPage': (context) => const RegisterPage(),
      },
    ),
  );
}
