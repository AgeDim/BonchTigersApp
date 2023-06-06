import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 30, left: 30),
            color: const Color(0xFFFE4500),
            child: Stack(
              children: [
                Positioned(
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
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset(
                    'assets/images/CircuitTiger.svg',
                  ),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
