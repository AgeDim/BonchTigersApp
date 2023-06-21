import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../services/snack_bar.dart';

class RegisterPresenter {
  final FirebaseAuth _firebaseAuth;
  final Function() onRegisterSuccess;
  final BuildContext context;
  final DatabaseReference userRef;

  RegisterPresenter(
      this._firebaseAuth, this.userRef, this.onRegisterSuccess, this.context);

  Future<void> register(String email, String password, String role) async {
    try {
      UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = credential.user;
      if (user != null) {
        userRef.child(user.uid).child('role').set(role);
        onRegisterSuccess();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        SnackBarService.showSnackBar(
          context,
          'Такой Email уже используется, повторите попытку с использованием другого Email',
          true,
        );
        return;
      } else {
        SnackBarService.showSnackBar(
          context,
          'Неизвестная ошибка! Попробуйте еще раз или обратитесь в поддержку.',
          true,
        );
      }
    }
  }
}
