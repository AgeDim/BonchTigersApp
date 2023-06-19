import 'package:flutter/material.dart';

class RoleContainer extends StatelessWidget {
  const RoleContainer({Key? key,
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
      margin:
      const EdgeInsets.symmetric(horizontal: 30),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: (isSelect)
              ? const Color(0xFFFE4500)
              : const Color(0xFFFF7643),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child:  Text(
          role,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
