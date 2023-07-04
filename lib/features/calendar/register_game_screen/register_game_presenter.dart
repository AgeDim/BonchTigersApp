import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../model/event.dart';
import '../../../services/snack_bar.dart';

class RegisterGamePresenter {
  final BuildContext context;
  final DatabaseReference eventsRef;
  final Function() onRegister;
  final Function() onUnRegister;
  final Function(Event event) updateFunc;

  RegisterGamePresenter(this.context, this.eventsRef, this.onRegister,
      this.onUnRegister, this.updateFunc);

  Future<void> registerUser(Event event, String? uid) async {
    if (event.id == null) {
      return;
    }

    try {
      DatabaseEvent events = await eventsRef.child(event.id!).once();
      DataSnapshot snapshot = events.snapshot;
      Map<dynamic, dynamic>? eventData =
          snapshot.value as Map<dynamic, dynamic>?;

      if (eventData != null) {
        List<String> registeredUser =
            List<String>.from(eventData['registeredUser'] ?? []);
        if (!registeredUser.contains(uid)) {
          registeredUser.add(uid!);
        } else {
          SnackBarService.showSnackBar(
            context,
            'You are already enrolled',
            true,
          );
          return;
        }
        await eventsRef
            .child(event.id!)
            .update({'registeredUser': registeredUser});
        event.registeredUser = registeredUser;
        updateFunc(event);
        onRegister();
      }
    } catch (error) {
      SnackBarService.showSnackBar(
        context,
        'Error adding user to event: $error',
        true,
      );
    }
  }

  Future<void> unRegisterUser(Event event, String? uid) async {
    if (event.id == null) {
      return;
    }

    try {
      DatabaseEvent events = await eventsRef.child(event.id!).once();
      DataSnapshot snapshot = events.snapshot;
      Map<dynamic, dynamic>? eventData =
          snapshot.value as Map<dynamic, dynamic>?;

      if (eventData != null) {
        List<String> registeredUser =
            List<String>.from(eventData['registeredUser'] ?? []);
        if (registeredUser.contains(uid)) {
          registeredUser.remove(uid!);
        }
        await eventsRef
            .child(event.id!)
            .update({'registeredUser': registeredUser});
        event.registeredUser = registeredUser;
        updateFunc(event);
        onUnRegister();
      }
    } catch (error) {
      SnackBarService.showSnackBar(
        context,
        'Error adding user to event: $error',
        true,
      );
    }
  }
}
