import 'package:bonch_tigers_app/features/login/login_presenter.dart';
import 'package:bonch_tigers_app/features/main_page/main_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:bonch_tigers_app/styles/style_library.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;

  late LoginPresenter _presenter;
  TextEditingController emailTextInputController = TextEditingController();
  TextEditingController passwordTextInputController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void navigateToMainPage() {
    Navigator.pushNamedAndRemoveUntil(
        context, '/mainPage', (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    _presenter = LoginPresenter(firebaseAuth, navigateToMainPage, context);
  }

  @override
  void dispose() {
    emailTextInputController.dispose();
    passwordTextInputController.dispose();

    super.dispose();
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> login() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    _presenter.login(
        emailTextInputController.text, passwordTextInputController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFE4500),
      //Переместил сюда, чтобы скролл могу работать на весь экран
      body: SingleChildScrollView(
        child: SizedBox(
          //из-за SingleChildScrollView экран имеет теперь бесконечнууую высоту.
          // Применим этот грубый хак и теперь все работает отлично. Но стоит такого избегать.
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 30, left: 30),
                child: Stack(
                  children: [
                     Positioned(
                      left: 0,
                      bottom: 30,
                      child: Text(
                        'Привет!',
                        textAlign: TextAlign.start,
                        //Делаем так. И тогда не нужно создавать отдельный стиль.
                        //Поэтому стоит аккуратно называть имена стилей, имена цветов не подойдут
                        style: StyleLibrary.text.gray34.copyWith(
                          color: Colors.white,
                        )
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
                            //todo: выше описал пример, стоит переделать везде такие места
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
                child: Form(
                  key: formKey,
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
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailTextInputController,
                            //todo: попробуй использовать Regex(), вместо отдельного пакета - для проверки валиддности email
                            //P.S ChatGPT очень хорошо генерирует регулярки с заданным запросом
                            validator: (email) =>
                                email != null && !EmailValidator.validate(email)
                                    ? 'Введите правильный Email'
                                    : null,
                          )),
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
                          validator: (value) => value != null && value.length < 6
                              ? 'Минимум 6 символов'
                              : null,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
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
                                    child: Text('ВОЙТИ',
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
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
