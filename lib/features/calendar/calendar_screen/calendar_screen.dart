import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pixel_snap/pixel_snap.dart';

import '../../../model/event.dart';
import '../../../styles/style_library.dart';
import 'calendar_widget.dart';
import 'event_list_widget.dart';

class CalendarScreen extends StatefulWidget {
  final String? role;
  final List<Event> events;
  final Function(Event event) addEvent;
  final DateTime selectedMonth;
  final Function(int index) deleteEvent;
  final Function(DateTime month) fetchEvents;
  final Function(Event event) updateEvent;

  const CalendarScreen(
      {super.key,
      required this.role,
      required this.events,
      required this.addEvent,
      required this.selectedMonth,
      required this.deleteEvent,
      required this.fetchEvents,
      required this.updateEvent});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime? _selectedDay;

  void setSelectedDay(DateTime? day) {
    setState(() {
      _selectedDay = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(27), topRight: Radius.circular(27)),
          color: Colors.white),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 100.pixelSnap(ps)),
                  child: SvgPicture.asset('assets/images/InvisibleTiger.svg'),
                ),
                CalendarWidget(
                    role: widget.role,
                    selDay: _selectedDay,
                    selectedMonth: widget.selectedMonth,
                    fetchEvents: widget.fetchEvents,
                    setSelectedDay: setSelectedDay,events: widget.events)
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 16.pixelSnap(ps)),
              alignment: Alignment.topLeft,
              child: Text(
                "Даты игр и тренировок",
                style: StyleLibrary.text.black16,
              ),
            ),
            EventListWidget(
              events: widget.events,
              selectedDay: _selectedDay,
              deleteEvent: widget.deleteEvent,
              addEvent: widget.addEvent,
              updateEvent: widget.updateEvent,
            )
          ],
        ),
      ),
    );
  }
}
