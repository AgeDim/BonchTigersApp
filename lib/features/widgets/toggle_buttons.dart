import 'package:flutter/material.dart';

class Switcher extends StatefulWidget {
  @override
  _SwitcherState createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> {
  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.green.withOpacity(0.5),
        child: ToggleButtons(
          isSelected: isSelected,
          selectedColor: Colors.white,
          color: Colors.black,
          fillColor: Colors.lightBlue.shade900,
          renderBorder: false,
          //splashColor: Colors.red,
          highlightColor: Colors.orange,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text('КАЛЕНДАРЬ', style: TextStyle(fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text('ЗАПИСЬ', style: TextStyle(fontSize: 18)),
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
      );
}
