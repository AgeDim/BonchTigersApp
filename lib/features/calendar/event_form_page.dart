import 'package:bonch_tigers_app/styles/style_library.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pixel_snap/pixel_snap.dart';
import 'package:intl/intl.dart';
import '../widgets/drop_down_menu.dart';

class EventFormPage extends StatefulWidget {
  const EventFormPage({super.key});

  @override
  State<EventFormPage> createState() => _EventFormPageState();
}

class _EventFormPageState extends State<EventFormPage> {
  TextEditingController timeEdittingController = TextEditingController();
  TextEditingController enemyEdittingController = TextEditingController();
  TextEditingController placeEdittingController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  List<String> getDatesUntilEndOfMonthAndNextTenDays() {
    final now = DateTime.now();
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0).day;
    final dateFormat = DateFormat('dd.MM.yy');

    List<String> dates = [];

    for (int i = now.day; i <= lastDayOfMonth; i++) {
      final date = DateTime(now.year, now.month, i);
      dates.add(dateFormat.format(date));
    }

    final nextMonth = now.month + 1;
    final nextMonthYear = now.year + (nextMonth > 12 ? 1 : 0);
    final nextMonthLastDay = DateTime(nextMonthYear, nextMonth + 1, 0).day;
    for (int i = 1; i <= 10; i++) {
      if (i <= nextMonthLastDay) {
        final date = DateTime(nextMonthYear, nextMonth, i);
        dates.add(dateFormat.format(date));
      } else {
        final date =
            DateTime(nextMonthYear, nextMonth + 1, i - nextMonthLastDay);
        dates.add(dateFormat.format(date));
      }
    }

    return dates;
  }

  String? selectedValue;

  void handleDateSelected(String? value) {
    setState(() {
      selectedValue = value;
    });
  }

  void submit() {}

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFFE4500),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 36.pixelSnap(ps)),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Ionicons.chevron_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      'Редактирование расписания',
                      style: StyleLibrary.text.white20,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: 30.pixelSnap(ps),
                      right: 30.pixelSnap(ps),
                      top: 30.pixelSnap(ps)),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Дата игры',
                            style: StyleLibrary.text.darkWhite12,
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 25.pixelSnap(ps)),
                            child: CustomDropDownMenu(
                              arrayOfElements:
                                  getDatesUntilEndOfMonthAndNextTenDays(),
                              onDateSelected: handleDateSelected,
                            ),
                          ),
                          Text(
                            'Вид спорта',
                            style: StyleLibrary.text.darkWhite12,
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 25.pixelSnap(ps)),
                            child: CustomDropDownMenu(
                              arrayOfElements:
                                  getDatesUntilEndOfMonthAndNextTenDays(),
                              onDateSelected: handleDateSelected,
                            ),
                          ),
                          Text(
                            'Время',
                            style: StyleLibrary.text.darkWhite12,
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 25.pixelSnap(ps)),
                            child: TextFormField(
                              controller: timeEdittingController,
                            ),
                          ),
                          Text(
                            'Соперник',
                            style: StyleLibrary.text.darkWhite12,
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 25.pixelSnap(ps)),
                            child: TextFormField(
                              controller: enemyEdittingController,
                            ),
                          ),
                          Text(
                            'Место',
                            style: StyleLibrary.text.darkWhite12,
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 76.pixelSnap(ps)),
                            child: TextFormField(
                              controller: placeEdittingController,
                            ),
                          ),
                          ElevatedButton(
                            style: StyleLibrary.button.orangeButton,
                            onPressed: submit,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      child: Text(
                                        'Сохранить',
                                        style: StyleLibrary.text.white16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
