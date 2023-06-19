import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void logout() {
    firebaseAuth.signOut();
    Navigator.pushNamedAndRemoveUntil(context, '/loginPage', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [ElevatedButton(onPressed: logout, child: Text('выйти'))],
          ),
        ),
      ),
    );
  }
}
