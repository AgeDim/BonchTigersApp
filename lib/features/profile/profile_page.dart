import 'package:bonch_tigers_app/features/profile/widgets/profile_form.dart';
import 'package:bonch_tigers_app/features/profile/widgets/profile_widget.dart';
import 'package:bonch_tigers_app/styles/style_library.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pixel_snap/pixel_snap.dart';

import '../login/login_page.dart';

class ProfilePage extends StatefulWidget {
  final String? role;

  const ProfilePage({super.key, required this.role});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void logout() {
    firebaseAuth.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, LoginPage.routeName, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    return Scaffold(
      backgroundColor: StyleLibrary.color.orange,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                  child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(
                        left: 20.pixelSnap(ps), top: 8.pixelSnap(ps)),
                    child: Text(
                      "Профиль",
                      style: StyleLibrary.text.white20,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 200,
                    width: 200,
                    margin: EdgeInsets.only(top: 10.pixelSnap(ps)),
                    child: SvgPicture.asset('assets/images/WhiteTigerFull.svg'),
                  ),
                ],
              )),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  padding: EdgeInsets.all(20.pixelSnap(ps)),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  child: Column(
                    children: [
                      ProfileWidget(role: widget.role),
                      Container(
                          margin: EdgeInsets.all(5.pixelSnap(ps)),
                          child: ProfileForm(role: widget.role)),
                      ElevatedButton(
                        onPressed: logout,
                        style: StyleLibrary.button.orangeButton,
                        child: Text(
                          'ВЫЙТИ',
                          style: StyleLibrary.text.white14,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
