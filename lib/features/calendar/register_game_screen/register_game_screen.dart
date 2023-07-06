import 'package:bonch_tigers_app/features/calendar/register_game_screen/game_list_widget.dart';
import 'package:flutter/material.dart';

import '../../../model/event.dart';

class RegisterGameScreen extends StatefulWidget {
  final List<Event> events;
  final Function(Event event) updateFunc;

  const RegisterGameScreen(
      {super.key, required this.events, required this.updateFunc});

  @override
  State<RegisterGameScreen> createState() => _RegisterGameScreenState();
}

class _RegisterGameScreenState extends State<RegisterGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(27), topLeft: Radius.circular(27))),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GameListWidget(
              events: widget.events,
              updateFunc: widget.updateFunc,
            )
          ],
        ),
      ),
    );
  }
}
