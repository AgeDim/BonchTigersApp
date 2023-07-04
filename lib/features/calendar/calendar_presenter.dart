import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/event.dart';
import '../../services/logger.dart';
import '../../services/snack_bar.dart';

class CalendarPresenter {
  final BuildContext context;
  final DatabaseReference eventsRef;

  CalendarPresenter(this.eventsRef, this.context);

  Future<List<Event>> getEventsForMonth(int currentMonth) async {
    final eventsRef = FirebaseDatabase.instance.ref().child('events');
    final firstDay = DateTime(DateTime.now().year, currentMonth, 1);
    final lastDay = DateTime(DateTime.now().year, currentMonth + 1, 0);
    final formattedFirstDay = DateFormat('dd.MM.yy').format(firstDay);
    final formattedLastDay = DateFormat('dd.MM.yy').format(lastDay);

    DatabaseEvent event = await eventsRef
        .orderByChild('date')
        .startAt(formattedFirstDay)
        .endAt(formattedLastDay)
        .once();
    DataSnapshot snapshot = event.snapshot;

    final eventMap = snapshot.value as Map<dynamic, dynamic>?;

    if (eventMap == null) {
      return [];
    }

    final events = eventMap.entries.map((entry) {
      final eventData = entry.value as Map<dynamic, dynamic>;
      return Event.fromJson(entry.key, eventData);
    }).toList();

    return events;
  }

  Future<bool> deleteEvent(String? eventId) async {
    try {
      DatabaseReference eventRef = FirebaseDatabase.instance.ref().child('events');
      await eventRef.child(eventId!).remove();
      SnackBarService.showSnackBar(
        context,
        'Event deleted successfully',
        true,
      );
      return true;
    } catch (error) {
      CustomLogger.error('Error deleting event: $error');
      return false;
    }
  }
}
