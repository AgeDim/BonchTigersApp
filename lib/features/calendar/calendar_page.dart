import 'package:bonch_tigers_app/features/calendar/calendar_screen/calendar_presenter.dart';
import 'package:bonch_tigers_app/features/calendar/calendar_screen/calendar_screen.dart';
import 'package:bonch_tigers_app/features/calendar/register_game_screen/register_game_screen.dart';
import 'package:bonch_tigers_app/styles/style_library.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pixel_snap/pixel_snap.dart';

import '../../model/event.dart';

class CalendarPage extends StatefulWidget {
  final String? role;

  const CalendarPage({super.key, required this.role});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late CalendarPresenter _presenter;
  List<Event> _events = [];
  DateTime _selectedMonth = DateTime.now();

  Future<void> _fetchEvents(DateTime month) async {
    List<Event> events = await _presenter.getEventsForMonth(month.month);
    setState(() {
      _events.clear();
      _events = events;
      _selectedMonth = month;
    });
  }

  void deleteEvent(int index) async {
    bool isDelete = await _presenter.deleteEvent(_events[index].id);
    if (isDelete) {
      setState(() {
        _events.removeAt(index);
      });
    }
  }

  void addEvent(Event event) {
    setState(() {
      _events.add(event);
    });
  }

  void updateEvent(Event event) {
    setState(() {
      _events[_events.indexWhere((element) => element.id == event.id)] = event;
    });
  }

  @override
  void initState() {
    super.initState();
    DatabaseReference eventRef =
        FirebaseDatabase.instance.reference().child('events');
    _tabController = TabController(length: 2, vsync: this);
    _presenter = CalendarPresenter(eventRef, context);
    _fetchEvents(_selectedMonth);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 30),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(
                top: 8.pixelSnap(ps),
                bottom: 44.pixelSnap(ps),
                left: 60.pixelSnap(ps),
                right: 60.pixelSnap(ps)),
            color: StyleLibrary.color.orange,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(25)),
              child: TabBar(
                automaticIndicatorColorAdjustment: false,
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                ),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.white,
                tabs: [
                  Tab(
                    child: Text(
                      'КАЛЕНДАРЬ',
                      style: StyleLibrary.text.text12,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'ЗАПИСЬ',
                      style: StyleLibrary.text.text12,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: StyleLibrary.color.orange,
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                CalendarScreen(
                  role: widget.role,
                  events: _events,
                  addEvent: addEvent,
                  selectedMonth: _selectedMonth,
                  deleteEvent: deleteEvent,
                  fetchEvents: _fetchEvents,
                  updateEvent: updateEvent,
                ),
                RegisterGameScreen(
                  events: _events,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
