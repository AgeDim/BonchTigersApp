import 'package:bonch_tigers_app/services/logger.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../../../model/event.dart';
import '../../../styles/style_library.dart';

class CalendarWidget extends StatefulWidget {
  final String? role;
  final DateTime? selDay;
  final DateTime selectedMonth;
  final Function(DateTime month) fetchEvents;
  final Function(DateTime? day) setSelectedDay;
  final List<Event> events;

  const CalendarWidget(
      {super.key,
      required this.role,
      required this.selDay,
      required this.selectedMonth,
      required this.fetchEvents,
      required this.setSelectedDay,
      required this.events});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  List<Event> getEventsForDay(DateTime selectedDate) {
    return widget.events
        .where((event) =>
            event.date == DateFormat('dd.MM.yy').format(selectedDate))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ru_RU',
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
            color: StyleLibrary.color.orange, shape: BoxShape.circle),
        defaultTextStyle: StyleLibrary.text.text16,
        weekendTextStyle: StyleLibrary.text.text16,
      ),
      eventLoader: (day) {
        return getEventsForDay(day);
      },
      selectedDayPredicate: (DateTime date) {
        return widget.selDay == date;
      },
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: widget.selectedMonth,
      startingDayOfWeek: StartingDayOfWeek.monday,
      onPageChanged: (date) {
        widget.fetchEvents(date);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (widget.role == "ТРЕНЕР") {
          if (widget.selDay == selectedDay) {
            widget.setSelectedDay(null);
          } else {
            widget.setSelectedDay(selectedDay);
          }
        }
      },
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          if (events.isNotEmpty) {
            return Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: StyleLibrary.color.lightOrange,
              ),
              alignment: Alignment.center,
              child:
                  Text(date.day.toString(), style: StyleLibrary.text.white16),
            );
          }
          return null;
        },
        selectedBuilder: (context, date, events) {
          return Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: StyleLibrary.border.all2black,
                color: StyleLibrary.color.orange),
            child: Center(
              child: Text(
                '${date.day}',
                style: StyleLibrary.text.white16,
              ),
            ),
          );
        },
        defaultBuilder: (context, date, _) {
          if (date.weekday == 7) {
            return Container(
              margin: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              alignment: Alignment.center,
              child:
                  Text(date.day.toString(), style: StyleLibrary.text.white16),
            );
          }
          return null;
        },
        outsideBuilder: (context, date, _) {
          if (date.weekday == DateTime.sunday) {
            return Container(
              margin: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              alignment: Alignment.center,
              child:
                  Text(date.day.toString(), style: StyleLibrary.text.white16),
            );
          }
          return null;
        },
      ),
    );
  }
}
