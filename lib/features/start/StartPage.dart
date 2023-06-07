import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 140),
              child: const Text('BONCH',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 61.65,
                    color: Color(0xFFFE4500),
                    height: 0.75,
                  )),
            ),
            const Text(
              'TIGERS',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 61.65,
                color: Color(0xFFFE4500),
                height: 0.75,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 155.38),
              child: SvgPicture.asset("assets/images/FullTiger.svg"),
            )
          ],
        ),
      ),
    );
  }
}