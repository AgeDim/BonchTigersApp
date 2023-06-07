import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscureText = true;
  String role = "БОЛЕЛЬЩИК";

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: const Color(0xFFFE4500),
      appBar: null,
      body: Column(
        children: [
          SafeArea(
              child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30, top: 18),
            child: SvgPicture.asset(
              'assets/images/CircuitTigerFull.svg',
            ),
          )),
          Expanded(
              child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50)),
                color: Colors.white),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 30, top: 33, bottom: 4),
                  child: const Text(
                    'Привет!',
                    style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: 34,
                      color: Color(0xFF3A3A3A),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 30),
                  child: const Text(
                    'Зарегистрируйтесь',
                    style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20,
                      color: Color(0xFF777777),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 41, left: 30),
                  child: const Opacity(
                    opacity: 0.7,
                    child: Text(
                      'Почта',
                      style: TextStyle(
                          fontFamily: 'Source Sans Pro',
                          fontSize: 12,
                          color: Color(0xFFA5A5A5)),
                    ),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextField()),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 35, left: 30),
                  child: const Opacity(
                    opacity: 0.7,
                    child: Text(
                      'Пароль',
                      style: TextStyle(
                          fontFamily: 'Source Sans Pro',
                          fontSize: 12,
                          color: Color(0xFFA5A5A5)),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                        obscureText: _obscureText,
                      ),
                    ),
                    Positioned(
                      right: 30,
                      top: 0,
                      bottom: 0,
                      child: IconButton(
                        onPressed: _toggle,
                        icon: Icon(_obscureText
                            ? Ionicons.eye_sharp
                            : Ionicons.eye_off_sharp),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 30, top: 35),
                  child: const Text(
                    'Вы:',
                    style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: 12,
                      color: Color(0xFFA5A5A5),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  role = "БОЛЕЛЬЩИК";
                                });
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: role == "БОЛЕЛЬЩИК"
                                    ? const Color(0xFFFE4500)
                                    : const Color(0xFFFF7643),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                "БОЛЕЛЬЩИК",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(right: 30),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  role = "ТРЕНЕР";
                                });
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: role == "ТРЕНЕР"
                                    ? const Color(0xFFFE4500)
                                    : const Color(0xFFFF7643),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                "ТРЕНЕР",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  role = "СПОРТСМЕН";
                                });
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: role == "СПОРТСМЕН"
                                    ? const Color(0xFFFE4500)
                                    : const Color(0xFFFF7643),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                "СПОРТСМЕН",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(right: 30),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  role = "ОРГАНИЗАТОР";
                                });
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: role == "ОРГАНИЗАТОР"
                                    ? const Color(0xFFFE4500)
                                    : const Color(0xFFFF7643),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                "ОРГАНИЗАТОР",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 40, left: 30, right: 30, bottom: 18),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: const MaterialStatePropertyAll<Color>(
                            Color(0xFFFE4500)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ))),
                    onPressed: _toggle,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: const Text(
                                'РЕГИСТРАЦИЯ',
                                style: TextStyle(
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Column(
                          children: [
                            Icon(Ionicons.arrow_forward_sharp),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}