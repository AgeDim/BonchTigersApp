import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';

import '../../styles/style_library.dart';

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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 30, top: 33, bottom: 4),
                    child: Text('Привет!', style: StyleLibrary.text.gray34),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 30),
                    child: Text('Зарегистрируйтесь',
                        style: StyleLibrary.text.lightGray20),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 41, left: 30),
                    child: Opacity(
                      opacity: 0.7,
                      child:
                          Text('Почта', style: StyleLibrary.text.darkWhite12),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextField()),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 35, left: 30),
                    child: Opacity(
                      opacity: 0.7,
                      child:
                          Text('Пароль', style: StyleLibrary.text.darkWhite12),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextField(
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: _toggle,
                              icon: Icon(_obscureText
                                  ? Ionicons.eye_sharp
                                  : Ionicons.eye_off_sharp))),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 30, top: 35),
                    child: Text('Вы:', style: StyleLibrary.text.darkWhite12),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: RoleContainer(
                              isSelect: role == 'БОЛЕЛЬЩИК',
                              onPressed: (){
                                setState(() {
                                  role = 'БОЛЕЛЬЩИК';
                                });
                              },
                              role: "БОЛЕЛЬЩИК",
                            ),
                          ),
                          Expanded(
                            child: RoleContainer(
                              isSelect: role == 'ТРЕНЕР',
                              onPressed: (){
                                setState(() {
                                  role = 'ТРЕНЕР';
                                });
                              },
                              role: "ТРЕНЕР",
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: RoleContainer(
                                isSelect: role == 'СПОРТСМЕН',
                                onPressed: (){
                                  setState(() {
                                    role = 'СПОРТСМЕН';
                                  });
                                },
                                role: "СПОРТСМЕН",
                            ),
                          ),
                          Expanded(
                            // Если внутри данные слишком большие, то контейнер расширяется вниз
                            // FittedBox поможет сжать контент. Надеюсь ничего не сломал из-за этого
                            child: FittedBox(
                              child: RoleContainer(
                                isSelect: role == 'ОРГАНИЗАТОР',
                                onPressed: (){
                                  setState(() {
                                    role = 'ОРГАНИЗАТОР';
                                  });
                                },
                                role: "ОРГАНИЗАТОР",
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
                      style: StyleLibrary.button.orangeButton,
                      onPressed: _toggle,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Text('РЕГИСТРАЦИЯ',
                                    style: StyleLibrary.text.white16),
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
            ),
          )),
        ],
      ),
    );
  }
}


//Заменил дубликаты на такой виджет, должно стать лаконичнее
class RoleContainer extends StatelessWidget {
  const RoleContainer({Key? key,
    required this.isSelect,
    required this.onPressed,
    required this.role,
  }) : super(key: key);

  final bool isSelect;
  final Function() onPressed;
  final String role;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
      const EdgeInsets.symmetric(horizontal: 30),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: (isSelect)
              ? const Color(0xFFFE4500)
              : const Color(0xFFFF7643),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child:  Text(
          role,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

