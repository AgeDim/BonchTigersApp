import 'package:bonch_tigers_app/features/calendar/calendar_presenter.dart';
import 'package:bonch_tigers_app/styles/style_library.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pixel_snap/pixel_snap.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../../model/event.dart';
import '../event_from_page/event_form_page.dart';

class CalendarPage extends StatefulWidget {
  final String? role;

  const CalendarPage({super.key, required this.role});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedMonth = DateTime.now();
  DateTime? _selectedDay;
  List<bool> isSelected = [true, false];
  List<Event> _events = [];
  late CalendarPresenter _presenter;

  Future<void> _fetchEvents(DateTime month) async {
    List<Event> events = await _presenter.getEventsForMonth(month.month);
    setState(() {
      _events.clear();
      _events = events;
      _selectedMonth = month;
    });
  }

  @override
  void initState() {
    super.initState();
    DatabaseReference eventRef =
        FirebaseDatabase.instance.reference().child('events');
    _presenter = CalendarPresenter(eventRef, context);
    _fetchEvents(_selectedMonth);
  }

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
                      child: Text('КАЛЕНДАРЬ', style: StyleLibrary.text.text12),
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
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
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
                                    calendarStyle: CalendarStyle(
                                      todayDecoration: const BoxDecoration(
                                          color: Color(0xFFFE4500),
                                          shape: BoxShape.circle),
                                      defaultTextStyle:
                                          StyleLibrary.text.text16,
                                      weekendTextStyle:
                                          StyleLibrary.text.text16,
                                    ),
                                    selectedDayPredicate: (DateTime date) {
                                      return _selectedDay == date;
                                    },
                                    firstDay: DateTime.utc(2010, 10, 16),
                                    lastDay: DateTime.utc(2030, 3, 14),
                                    focusedDay: _selectedMonth,
                                    startingDayOfWeek: StartingDayOfWeek.monday,
                                    onPageChanged: (date) {
                                      _fetchEvents(date);
                                    },
                                    onDaySelected: (selectedDay, focusedDay) {
                                      if (widget.role == "ТРЕНЕР") {
                                        setState(() {
                                          _selectedDay = selectedDay;
                                        });
                                      }
                                    },
                                    calendarBuilders: CalendarBuilders(
                                      selectedBuilder: (context, date, events) {
                                        return Container(
                                          margin: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 2.0),
                                              color: const Color(0xFFFE4500)),
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
                                            child: Text(date.day.toString(),
                                                style:
                                                    StyleLibrary.text.white16),
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
                                                style:
                                                    StyleLibrary.text.white16),
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
                              ),
                              ListView.builder(
                                  padding: const EdgeInsets.all(8),
                                  itemCount: _events.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      margin: EdgeInsets.all(10.pixelSnap(ps)),
                                      padding: EdgeInsets.all(15.pixelSnap(ps)),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: const Color(0xFFFF7643))),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Игра. СПБГУТ - ${_events[index].enemy.toUpperCase()}',
                                                style: StyleLibrary.text.gray16,
                                              ),
                                              Text(
                                                _events[index].sport,
                                                style:
                                                    StyleLibrary.text.orange14,
                                              )
                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.pixelSnap(ps)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  DateFormat('dd MMMM HH:mm',
                                                          'ru_RU')
                                                      .format(DateFormat(
                                                              'dd.MM.yy HH:mm')
                                                          .parse(
                                                              '${_events[index].date} ${_events[index].time}')),
                                                  style:
                                                      StyleLibrary.text.gray14,
                                                ),
                                                Text(
                                                  _events[index].place,
                                                  style:
                                                      StyleLibrary.text.gray14,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                              Visibility(
                                visible: _selectedDay != null,
                                child: Container(
                                  margin:
                                      EdgeInsets.only(bottom: 10.pixelSnap(ps)),
                                  child: ElevatedButton(
                                    style: StyleLibrary.button.orangeButton,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EventFormPage(
                                              selectedDay:
                                                  DateFormat('dd.MM.yy')
                                                      .format(_selectedDay!)),
                                        ),
                                      );
                                    },
                                    child: SizedBox(
                                      width: 314.pixelSnap(ps),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Column(
                                            children: [
                                              Icon(
                                                Ionicons.add_outline,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 15.pixelSnap(ps)),
                                                child: Text('ДОБАВИТЬ',
                                                    style: StyleLibrary
                                                        .text.white16),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
