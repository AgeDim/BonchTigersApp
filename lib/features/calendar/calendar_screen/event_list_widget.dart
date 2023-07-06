import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pixel_snap/pixel_snap.dart';
import 'package:intl/intl.dart';

import '../../../model/event.dart';
import '../../../styles/style_library.dart';
import '../../event_from_page/event_form_page.dart';

class EventListWidget extends StatelessWidget {
  final List<Event> events;
  final DateTime? selectedDay;
  final Function(int index) deleteEvent;
  final Function(Event event) addEvent;
  final Function(Event event) updateEvent;

  const EventListWidget(
      {super.key,
      required this.events,
      required this.selectedDay,
      required this.deleteEvent,
      required this.addEvent,
      required this.updateEvent});

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    return Column(
      children: [
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            itemCount: events.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.all(10.pixelSnap(ps)),
                padding: EdgeInsets.all(15.pixelSnap(ps)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: StyleLibrary.color.lightOrange)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Игра. СПБГУТ - ${events[index].enemy.toUpperCase()}',
                          style: StyleLibrary.text.gray16,
                          textAlign: TextAlign.left,
                        ),
                        Flexible(
                            child: Text(
                          events[index].sport,
                          style: StyleLibrary.text.orange14,
                          textAlign: TextAlign.right,
                        ))
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5.pixelSnap(ps)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat('dd MMMM HH:mm', 'ru_RU').format(
                                    DateFormat('dd.MM.yy HH:mm').parse(
                                        '${events[index].date} ${events[index].time}')),
                                style: StyleLibrary.text.gray14,
                              ),
                              Text(
                                events[index].place,
                                style: StyleLibrary.text.gray14,
                              ),
                            ],
                          ),
                          if (selectedDay != null)
                            if (events[index].date ==
                                DateFormat('dd.MM.yy').format(selectedDay!))
                              Container(
                                padding: EdgeInsets.only(top: 5.pixelSnap(ps)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      style: StyleLibrary.button.orangeButton,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EventFormPage(
                                              selectedDay:
                                                  DateFormat('dd.MM.yy')
                                                      .format(selectedDay!),
                                              addFunc: addEvent,
                                              event: events[index],
                                              updateFunc: updateEvent,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Column(
                                            children: [
                                              Icon(
                                                Ionicons.pencil_sharp,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text('ИЗМЕНИТЬ',
                                                style:
                                                    StyleLibrary.text.white14),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: StyleLibrary.button.orangeButton,
                                      onPressed: () {
                                        deleteEvent(index);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Column(
                                            children: [
                                              Icon(
                                                Ionicons.trash_outline,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text('УДАЛИТЬ',
                                                style:
                                                    StyleLibrary.text.white14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
        Visibility(
          visible: selectedDay != null,
          child: Container(
            margin: EdgeInsets.only(bottom: 10.pixelSnap(ps)),
            child: ElevatedButton(
              style: StyleLibrary.button.orangeButton,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventFormPage(
                      selectedDay: DateFormat('dd.MM.yy').format(selectedDay!),
                      addFunc: addEvent,
                      updateFunc: updateEvent,
                    ),
                  ),
                );
              },
              child: SizedBox(
                width: 314.pixelSnap(ps),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          padding:
                              EdgeInsets.symmetric(vertical: 15.pixelSnap(ps)),
                          child: Text('ДОБАВИТЬ',
                              style: StyleLibrary.text.white16),
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
    );
  }
}
