import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFFE4500),
      appBar: null,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 30, left: 30),
            child: Stack(
              children: [
                const Positioned(
                  left: 0,
                  bottom: 30,
                  child: Text(
                    'Привет!',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: 34,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Positioned(
                    left: 0,
                    bottom: 0,
                    child: Opacity(
                      opacity: 0.9,
                      child: Text(
                        'Войдите, чтобы продолжить',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontFamily: 'Source Sans Pro',
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    )),
                SafeArea(
                    child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset(
                    'assets/images/CircuitTiger.svg',
                  ),
                ))
              ],
            ),
          ),
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
                  margin: const EdgeInsets.only(top: 50, left: 30),
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
                                'ВОЙТИ',
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
                Container(
                  margin: const EdgeInsets.only(right: 33),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/registerPage');
                      },
                      child: const Text(
                        "Нет аккаунта?",
                        style: TextStyle(color: Color(0xFFFE4500)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}