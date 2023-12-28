import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DropDownText extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;

  DropDownText({required this.hintText, required this.prefixIcon});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          prefixIcon,
        ),
        SizedBox(width: 16),
        Text(
          hintText,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
