import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../model/event.dart';
import '../../services/snack_bar.dart';

class EventFormPresenter {
  final BuildContext context;
  final DatabaseReference eventsRef;
  final Function() onAddedSuccessfully;
  final Function() onUpdateSuccessfully;
  final Function(Event event) addFunc;

  EventFormPresenter(this.eventsRef, this.onAddedSuccessfully,
      this.onUpdateSuccessfully, this.addFunc, this.context);

  Future<void> addEvent(String date, String sport, String time, String enemy,
      String place) async {
    try {
      DatabaseEvent event =
          await eventsRef.orderByChild('date').equalTo(date).once();
      DataSnapshot snapshot = event.snapshot;
      Map<dynamic, dynamic>? eventData =
          snapshot.value as Map<dynamic, dynamic>?;

      if (eventData != null) {
        String eventId = eventData.keys.first;
        Event updatedEvent = Event(
          id: eventId,
          date: date,
          sport: sport,
          time: time,
          enemy: enemy,
          place: place,
        );
        await eventsRef.child(eventId).update(updatedEvent.toJson());
        onUpdateSuccessfully();
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
        );
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
