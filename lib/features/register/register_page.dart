import 'package:bonch_tigers_app/features/register/register_presenter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';

import '../../styles/style_library.dart';
import '../widgets/role_container.dart';
import '../main_page/main_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static const routeName = '/registerPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscureText = true;
  String role = "БОЛЕЛЬЩИК";

  late RegisterPresenter _presenter;
  TextEditingController emailTextInputController = TextEditingController();
  TextEditingController passwordTextInputController = TextEditingController();
  TextEditingController nameTextInputController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void navigateToMainPage() {
    Navigator.pushNamedAndRemoveUntil(
        context, MainPage.routeName, (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    DatabaseReference userRef =
        FirebaseDatabase.instance.ref().child('users');
    _presenter =
        RegisterPresenter(firebaseAuth, userRef, navigateToMainPage, context);
  }

  @override
  void dispose() {
    emailTextInputController.dispose();
    passwordTextInputController.dispose();
    nameTextInputController.dispose();

    super.dispose();
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> register() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    _presenter.register(emailTextInputController.text.trim(),nameTextInputController.text.trim(),
        passwordTextInputController.text.trim(), role);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StyleLibrary.color.orange,
      appBar: null,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SafeArea(
                child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 30, top: 18),
              child: SvgPicture.asset(
                'assets/images/CircuitTigerFull.svg',
              ),
            )),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50)),
                  color: Colors.white),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin:
                            const EdgeInsets.only(left: 30, top: 23, bottom: 4),
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
                        margin: const EdgeInsets.only(top: 21, left: 30),
                        child: Opacity(
                          opacity: 0.7,
                          child: Text('Почта',
                              style: StyleLibrary.text.darkWhite12),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailTextInputController,
                            validator: (value) {
                              if (value == null) {
                                return 'Пожалуйста введите почту';
                              } else if (!RegExp(
                                      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                                  .hasMatch(value)) {
                                return 'Пожалуйста введите корректную почту';
                              }
                              return null; // Return null if the email is valid
                            },
                          )),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 41, left: 30),
                        child: Opacity(
                          opacity: 0.7,
                          child: Text('Имя',
                              style: StyleLibrary.text.darkWhite12),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            controller: nameTextInputController,
                            validator: (value) {
                              if (value == null) {
                                return 'Пожалуйста введите имя';
                              } else if (!RegExp(r'^[А-ЯЁа-яё\s]+$')
                                  .hasMatch(value)) {
                                return 'Пожалуйста введите имя на кириллице';
                              }
                              return null; // Return null if the email is valid
                            },
                          )),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 25, left: 30),
                        child: Opacity(
                          opacity: 0.7,
                          child: Text('Пароль',
                              style: StyleLibrary.text.darkWhite12),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                          controller: passwordTextInputController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: _toggle,
                                  icon: Icon(_obscureText
                                      ? Ionicons.eye_sharp
                                      : Ionicons.eye_off_sharp))),
                          validator: (value) =>
                              value != null && value.length < 6
                                  ? 'Минимум 6 символов'
                                  : null,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 30, top: 35),
                        child:
                            Text('Вы:', style: StyleLibrary.text.darkWhite12),
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: RoleContainer(
                                  isSelect: role == 'БОЛЕЛЬЩИК',
                                  onPressed: () {
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
                                  onPressed: () {
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
                                  onPressed: () {
                                    setState(() {
                                      role = 'СПОРТСМЕН';
                                    });
                                  },
                                  role: "СПОРТСМЕН",
                                ),
                              ),
                              Expanded(
                                child: RoleContainer(
                                  isSelect: role == 'ОРГАНИЗАТОР',
                                  onPressed: () {
                                    setState(() {
                                      role = 'ОРГАНИЗАТОР';
                                    });
                                  },
                                  role: "ОРГАНИЗАТОР",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 30, left: 30, right: 30, bottom: 18),
                        child: ElevatedButton(
                          style: StyleLibrary.button.orangeButton,
                          onPressed: register,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
