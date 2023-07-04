import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CustomDropDownMenu extends StatefulWidget {
  const CustomDropDownMenu(
      {super.key,
      required this.arrayOfElements,
      required this.onDateSelected,
      this.defaultValue});

  final List<String> arrayOfElements;
  final Function(String?) onDateSelected;
  final String? defaultValue;

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  String? selectedDate;

  @override
  void initState() {
    selectedDate = widget.defaultValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedDate,
      onChanged: (String? value) {
        setState(() {
          selectedDate = value;
        });
        widget.onDateSelected(value);
      },
      menuMaxHeight: 400,
      isExpanded: true,
      icon: const Icon(Ionicons.chevron_down),
      items:
          widget.arrayOfElements.map<DropdownMenuItem<String>>((String date) {
        return DropdownMenuItem<String>(
          value: date,
          child: Text(date),
        );
      }).toList(),
    );
  }
}
