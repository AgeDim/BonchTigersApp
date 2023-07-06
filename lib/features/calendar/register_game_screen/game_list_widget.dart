import 'package:bonch_tigers_app/features/calendar/register_game_screen/register_game_presenter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pixel_snap/pixel_snap.dart';
import 'package:intl/intl.dart';

import '../../../model/event.dart';
import '../../../services/snack_bar.dart';
import '../../../styles/style_library.dart';

class GameListWidget extends StatefulWidget {
  final List<Event> events;
  final Function(Event event) updateFunc;

  const GameListWidget(
      {super.key, required this.events, required this.updateFunc});

  @override
  State<GameListWidget> createState() => _GameListWidgetState();
}

class _GameListWidgetState extends State<GameListWidget> {
  late RegisterGamePresenter _presenter;

  String convertDateToRussian(String date) {
    final parsedDate = DateFormat('dd.MM.yy').parse(date);
    final formattedDate = DateFormat('dd MMMM', 'ru_RU').format(parsedDate);
    final monthName = formattedDate.split(' ')[1];
    return '${formattedDate.split(' ')[0]} $monthName';
  }

  void registerUserOnGame(Event event) {
    _presenter.registerUser(event, FirebaseAuth.instance.currentUser?.uid);
  }

  void unRegisterUserOnGame(Event event) {
    _presenter.unRegisterUser(event, FirebaseAuth.instance.currentUser?.uid);
  }

  void onRegister() {
    SnackBarService.showSnackBar(
      context,
      'You have successfully enrolled',
      true,
    );
  }

  void onUnRegister() {
    SnackBarService.showSnackBar(
      context,
      'You have successfully unsubscribed',
      true,
    );
  }

  @override
  void initState() {
    super.initState();
    DatabaseReference eventRef =
        FirebaseDatabase.instance.ref().child('events');
    _presenter = RegisterGamePresenter(
        context, eventRef, onRegister, onUnRegister, widget.updateFunc);
  }

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(8),
        itemCount: widget.events.length,
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
                  child: Text(convertDateToRussian(widget.events[index].date),
                      style: StyleLibrary.text.dark_orange14),
                ),
                Container(
                  margin: EdgeInsets.all(5.pixelSnap(ps)),
                  child: Text(
                    'Игра. СПБГУТ - ${widget.events[index].enemy.toUpperCase()}',
                    style: StyleLibrary.text.gray16,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5.pixelSnap(ps)),
                  child: Text(
                    widget.events[index].sport,
                    style: StyleLibrary.text.orange14,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.all(5.pixelSnap(ps)),
                      child: Text(
                        widget.events[index].place,
                        style: StyleLibrary.text.gray14,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5.pixelSnap(ps)),
                      child: Text(
                        widget.events[index].time,
                        style: StyleLibrary.text.black16,
                      ),
                    )
                  ],
                ),
                if (widget.events[index].registeredUser.length < 20 &&
                    !widget.events[index].registeredUser
                        .contains(FirebaseAuth.instance.currentUser?.uid))
                  ElevatedButton(
                    onPressed: () {
                      registerUserOnGame(widget.events[index]);
                    },
                    style: StyleLibrary.button.orangeButton,
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 12.pixelSnap(ps)),
                        width: double.infinity,
                        child: Text(
                          'ЗАПИСАТЬСЯ НА ИГРУ',
                          style: StyleLibrary.text.white14,
                          textAlign: TextAlign.center,
                        )),
                  ),
                if (widget.events[index].registeredUser
                    .contains(FirebaseAuth.instance.currentUser?.uid))
                  ElevatedButton(
                    onPressed: () {
                      unRegisterUserOnGame(widget.events[index]);
                    },
                    style: StyleLibrary.button.orangeButton,
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 12.pixelSnap(ps)),
                        width: double.infinity,
                        child: Text(
                          'ОТПИСАТЬСЯ ОТ ИГРЫ',
                          style: StyleLibrary.text.white14,
                          textAlign: TextAlign.center,
                        )),
                  ),
              ],
            ),
          );
        });
  }
}
