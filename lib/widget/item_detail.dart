import 'package:flutter/material.dart';
import 'package:tkt_voucher/resource/dimens.dart';
import 'package:tkt_voucher/resource/strings.dart';

class ItemDetail extends StatelessWidget {
  final String title;
  final String value;
  ItemDetail({this.title = "", this.value = ""});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2.5,
          child: Text(
            title,
            style: TextStyle(
              fontSize: TEXT_REGULAR_3X,
            ),
          ),
        ),
        SizedBox(width: MARGIN_CARD_MEDIUM_2),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: TEXT_REGULAR_3X,
            ),
          ),
        ),
      ],
    );
  }
}
