import 'package:bonch_tigers_app/styles/style_library.dart';
import 'package:flutter/material.dart';

class RoleContainer extends StatelessWidget {
  const RoleContainer({
    Key? key,
    required this.isSelect,
    required this.onPressed,
    required this.role,
  }) : super(key: key);

  final bool isSelect;
  final Function() onPressed;
  final String role;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor:
              (isSelect) ? StyleLibrary.color.orange : StyleLibrary.color.lightOrange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(role, style: StyleLibrary.text.white16),
      ),
    );
  }
}
