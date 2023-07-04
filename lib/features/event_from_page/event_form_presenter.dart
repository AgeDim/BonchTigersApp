import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../model/event.dart';
import '../../services/logger.dart';
import '../../services/snack_bar.dart';

class EventFormPresenter {
  final BuildContext context;
  final DatabaseReference eventsRef;
  final Function() onAddedSuccessfully;
  final Function() onUpdateSuccessfully;
  final Function(Event event) addFunc;
  final Function(Event event) updateFunc;

  EventFormPresenter(this.eventsRef, this.onAddedSuccessfully,
      this.onUpdateSuccessfully, this.addFunc, this.context, this.updateFunc);

  Future<void> addEvent(String? id, String date, String sport, String time,
      String enemy, String place) async {
    CustomLogger.info(id);
    try {
      if (id != null) {
        DatabaseEvent event = await eventsRef.child(id!).once();
        DataSnapshot snapshot = event.snapshot;
        Map<dynamic, dynamic>? eventData =
            snapshot.value as Map<dynamic, dynamic>?;

        if (eventData != null) {
          Event updatedEvent = Event(
              id: id,
              date: date,
              sport: sport,
              time: time,
              enemy: enemy,
              place: place,
              registeredUser: []);
          await eventsRef.child(id).update(updatedEvent.toJson());
          updateFunc(updatedEvent);
          onUpdateSuccessfully();
        }
      } else {
        final newEventRef = eventsRef.push();
        final newEventId = newEventRef.key;
        Event newEvent = Event(
            id: newEventId,
            date: date,
            sport: sport,
            time: time,
            enemy: enemy,
            place: place,
            registeredUser: []);
        await newEventRef.set(newEvent.toJson());
        addFunc(newEvent);
        onAddedSuccessfully();
      }
    } catch (error) {
      SnackBarService.showSnackBar(
        context,
        'Error adding/updating event: $error',
        true,
      );
      return;
    }
  }
}
