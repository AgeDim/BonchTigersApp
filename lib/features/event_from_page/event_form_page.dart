import 'package:bonch_tigers_app/features/event_from_page/event_form_presenter.dart';
import 'package:bonch_tigers_app/model/event.dart';
import 'package:bonch_tigers_app/styles/style_library.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pixel_snap/pixel_snap.dart';
import '../../services/snack_bar.dart';
import '../widgets/drop_down_menu.dart';
import 'package:intl/intl.dart';

class EventFormPage extends StatefulWidget {
  const EventFormPage(
      {super.key,
      required this.selectedDay,
      required this.addFunc,
      required this.updateFunc,
      this.event});

  final Event? event;
  final String selectedDay;
  final Function(Event event) addFunc;
  final Function(Event event) updateFunc;

  @override
  State<EventFormPage> createState() => _EventFormPageState();
}

class _EventFormPageState extends State<EventFormPage> {
  TextEditingController timeInputController = TextEditingController();
  TextEditingController enemyInputController = TextEditingController();
  TextEditingController placeInputController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late EventFormPresenter _presenter;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.selectedDay;
    selectedSport = sports.first;
    enemyInputController.text = widget.event != null ? widget.event!.enemy : '';
    placeInputController.text = widget.event != null ? widget.event!.place : '';
    timeInputController.text = widget.event != null ? widget.event!.time : '';
    DatabaseReference eventRef =
        FirebaseDatabase.instance.reference().child('events');
    _presenter = EventFormPresenter(eventRef, onAdded, onUpdate, widget.addFunc,
        context, widget.updateFunc);
  }

  @override
  void dispose() {
    timeInputController.dispose();
    enemyInputController.dispose();
    placeInputController.dispose();

    super.dispose();
  }

  final List<String> sports = [
    'Баскетбол',
    'Волейбол',
    'Футбол',
    'Настольный теннис',
    'Гандбол',
    'Гребля',
    'Плавание'
  ];

  List<String> getDaysAfterSelectedDay(String selectedDay) {
    DateFormat dateFormat = DateFormat('dd.MM.yy');
    DateTime selectedDateTime = dateFormat.parse(selectedDay);
    DateTime lastDayOfMonth =
        DateTime(selectedDateTime.year, selectedDateTime.month + 1, 0);

    List<String> daysAfterSelected = [];
    for (int i = selectedDateTime.day; i <= lastDayOfMonth.day; i++) {
      DateTime day = DateTime(selectedDateTime.year, selectedDateTime.month, i);
      String formattedDay =
          '${day.day.toString().padLeft(2, '0')}.${day.month.toString().padLeft(2, '0')}.${day.year.toString().substring(2)}';
      daysAfterSelected.add(formattedDay);
    }

    return daysAfterSelected;
  }

  String? selectedDate;
  String? selectedSport;

  void handleSportSelected(String? value) {
    setState(() {
      selectedSport = value;
    });
  }

  void onAdded() {
    SnackBarService.showSnackBar(
      context,
      'Event added successfully!',
      true,
    );
  }

  void onUpdate() {
    SnackBarService.showSnackBar(
      context,
      'Event update successfully!',
      true,
    );
  }

  void handleDateSelected(String? value) {
    setState(() {
      selectedDate = value;
    });
  }

  Future<void> submit() async {
    if (formKey.currentState!.validate()) {
      if (selectedDate == null ||
          selectedSport == null ||
          timeInputController.text.isEmpty ||
          enemyInputController.text.isEmpty ||
          placeInputController.text.isEmpty) {
        SnackBarService.showSnackBar(
          context,
          'Please select a date and sport',
          true,
        );
        return;
      } else {
        _presenter.addEvent(widget.event?.id,
            selectedDate.toString(),
            selectedSport.toString(),
            timeInputController.text.trim(),
            enemyInputController.text.trim(),
            placeInputController.text.trim());
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    return Scaffold(
      backgroundColor: StyleLibrary.color.orange,
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
                                  getDaysAfterSelectedDay(widget.selectedDay),
                              onDateSelected: handleDateSelected,
                              defaultValue: widget.selectedDay,
                            ),
                          ),
                          Text(
                            'Вид спорта',
                            style: StyleLibrary.text.darkWhite12,
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 25.pixelSnap(ps)),
                            child: CustomDropDownMenu(
                                arrayOfElements: sports,
                                onDateSelected: handleSportSelected,
                                defaultValue: widget.event?.sport),
                          ),
                          Text(
                            'Время',
                            style: StyleLibrary.text.darkWhite12,
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 25.pixelSnap(ps)),
                            child: TextFormField(
                              controller: timeInputController,
                              keyboardType: TextInputType.datetime,
                              validator: (value) {
                                if (value == null) {
                                  return 'Пожалуйста введите время';
                                } else if (!RegExp(
                                        r'^([01]\d|2[0-3]):([0-5]\d)$')
                                    .hasMatch(value)) {
                                  return 'Пожалуйста введите корректное время';
                                }
                                return null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                          ),
                          Text(
                            'Соперник',
                            style: StyleLibrary.text.darkWhite12,
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 25.pixelSnap(ps)),
                            child: TextFormField(
                              controller: enemyInputController,
                            ),
                          ),
                          Text(
                            'Место',
                            style: StyleLibrary.text.darkWhite12,
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 76.pixelSnap(ps)),
                            child: TextFormField(
                              controller: placeInputController,
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
