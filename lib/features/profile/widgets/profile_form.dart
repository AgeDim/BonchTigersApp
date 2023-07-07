import 'package:bonch_tigers_app/styles/style_library.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pixel_snap/pixel_snap.dart';

class ProfileForm extends StatefulWidget {
  final String? role;

  const ProfileForm({super.key, required this.role});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Container(
            margin: EdgeInsets.only(right: 10.pixelSnap(ps)),
            width: MediaQuery.of(context).size.width / 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Количество  посещенных игр",
                  style: StyleLibrary.text.gray14,
                  textAlign: TextAlign.start,
                ),
                TextFormField(
                  style: StyleLibrary.text.black20,
                  enabled: false,
                  initialValue: "8",
                ),
              ],
            ),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Место в рейтинге",
                    style: StyleLibrary.text.gray14,
                  ),
                  TextFormField(
                    style: StyleLibrary.text.black20,
                    enabled: false,
                    initialValue: "200",
                  ),
                ],
              ))
        ]),
        Container(
          margin: EdgeInsets.only(top: 35.pixelSnap(ps)),
          child: Text(
            "Роль",
            style: StyleLibrary.text.gray14,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: TextFormField(
            style: StyleLibrary.text.black20,
            enabled: false,
            initialValue: widget.role,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 35.pixelSnap(ps)),
          child: Text(
            "Почта",
            style: StyleLibrary.text.gray14,
          ),
        ),
        TextFormField(
          enabled: false,
          initialValue: FirebaseAuth.instance.currentUser?.email,
          validator: (value) {
            if (value == null) {
              return 'Пожалуйста введите почту';
            } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                .hasMatch(value)) {
              return 'Пожалуйста введите корректную почту';
            }
            return null;
          },
        )
      ],
    );
  }
}
