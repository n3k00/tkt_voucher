import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class DividerDottedLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DottedLine(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      lineLength: double.infinity,
      lineThickness: 1.5,
      dashLength: 10.0,
      dashColor: Colors.black,
      dashRadius: 0.0,
      dashGapLength: 4.0,
      dashGapRadius: 0.0,
    );
  }
}
