import 'package:bonch_tigers_app/styles/style_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pixel_snap/pixel_snap.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../event_from_page/event_form_page.dart';

class CalendarPage extends StatefulWidget {
  String? role;

  CalendarPage({super.key, required this.role});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    return Container(
      color: const Color(0xFFFE4500),
      child: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: 5.pixelSnap(ps), bottom: 44.12.pixelSnap(ps)),
                height: 35.pixelSnap(ps),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ToggleButtons(
                  isSelected: isSelected,
                  selectedColor: Colors.black,
                  color: Colors.white,
                  fillColor: Colors.white,
                  renderBorder: false,
                  highlightColor: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 22.pixelSnap(ps),
                          vertical: 7.pixelSnap(ps)),
                      child: Text('КАЛЕНДАРЬ', style: StyleLibrary.text.text16),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 22.pixelSnap(ps),
                          vertical: 7.pixelSnap(ps)),
                      child: Text('ЗАПИСЬ', style: StyleLibrary.text.text16),
                    )
                  ],
                  onPressed: (int newIndex) {
                    setState(() {
                      for (int index = 0; index < isSelected.length; index++) {
                        if (index == newIndex) {
                          isSelected[index] = true;
                        } else {
                          isSelected[index] = false;
                        }
                      }
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30)),
                      color: Colors.white),
                  child: Column(
                    children: [
                      Visibility(
                        visible: isSelected[0],
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.only(top: 100.pixelSnap(ps)),
                                  child: SvgPicture.asset(
                                      'assets/images/InvisibleTiger.svg'),
                                ),
                                TableCalendar(
                                  locale: 'ru_RU',
                                  headerStyle: const HeaderStyle(
                                    formatButtonVisible: false,
                                    titleCentered: true,
                                  ),
                                  firstDay: DateTime.utc(2010, 10, 16),
                                  lastDay: DateTime.utc(2030, 3, 14),
                                  focusedDay: DateTime.now(),
                                  startingDayOfWeek: StartingDayOfWeek.monday,
                                  onDaySelected: (selectedDay, focusedDay) {
                                    if (widget.role == "ТРЕНЕР") {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EventFormPage(
                                              selectedDay:
                                                  DateFormat('dd.MM.yy')
                                                      .format(selectedDay)),
                                        ),
                                      );
                                    }
                                  },
                                  calendarBuilders: CalendarBuilders(
                                    defaultBuilder: (context, date, _) {
                                      if (date.weekday == 7) {
                                        return Container(
                                          margin: const EdgeInsets.all(5),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.black,
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(date.day.toString(),
                                              style: StyleLibrary.text.white16),
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
                                          child: Text(date.day.toString(),
                                              style: StyleLibrary.text.white16),
                                        );
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 16.pixelSnap(ps)),
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Даты игр и тренировок",
                                style: StyleLibrary.text.black16,
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                          visible: isSelected[1],
                          child: const Column(
                            children: [],
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
