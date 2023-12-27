import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DropDownHint extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;

  DropDownHint({required this.hintText, required this.prefixIcon});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          prefixIcon,
          color: Theme.of(context).hintColor,
        ),
        SizedBox(width: 16),
        Text(
          hintText,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
