import 'package:flutter/material.dart';
import 'package:pixel_snap/pixel_snap.dart';
import 'package:intl/intl.dart';

import '../../../model/event.dart';
import '../../../services/logger.dart';
import '../../../styles/style_library.dart';

class GameListWidget extends StatelessWidget {
  final List<Event> events;

  const GameListWidget({super.key, required this.events});

  String convertDateToRussian(String date) {
    final parsedDate = DateFormat('dd.MM.yy').parse(date);
    final formattedDate = DateFormat('dd MMMM', 'ru_RU').format(parsedDate);
    final monthName = formattedDate.split(' ')[1];
    return '${formattedDate.split(' ')[0]} $monthName';
  }
  void registerUserOnGame(){

  }

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: events.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.all(7.pixelSnap(ps)),
            padding: EdgeInsets.all(10.pixelSnap(ps)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: StyleLibrary.color.lightOrange)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(5.pixelSnap(ps)),
                  padding: EdgeInsets.symmetric(
                      horizontal: 5.pixelSnap(ps), vertical: 2.pixelSnap(ps)),
                  decoration: BoxDecoration(
                    color: StyleLibrary.color.lightOrange,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(convertDateToRussian(events[index].date),
                      style: StyleLibrary.text.dark_orange14),
                ),
                Container(
                  margin: EdgeInsets.all(5.pixelSnap(ps)),
                  child: Text(
                    'Игра. СПБГУТ - ${events[index].enemy.toUpperCase()}',
                    style: StyleLibrary.text.gray16,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5.pixelSnap(ps)),
                  child: Text(
                    events[index].sport,
                    style: StyleLibrary.text.orange14,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.all(5.pixelSnap(ps)),
                      child: Text(
                        events[index].place,
                        style: StyleLibrary.text.gray14,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5.pixelSnap(ps)),
                      child: Text(
                        events[index].time,
                        style: StyleLibrary.text.black16,
                      ),
                    )
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: StyleLibrary.button.orangeButton,
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.pixelSnap(ps)),
                      width: double.infinity,
                      child: Text(
                        'ЗАПИСАТЬСЯ НА ИГРУ',
                        style: StyleLibrary.text.white14,
                        textAlign: TextAlign.center,
                      )),
                )
              ],
            ),
          );
        });
  }
}
