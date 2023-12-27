import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:tkt_voucher/resource/dimens.dart';

var INPUT_TEXT_FIELD_STYLE = InputDecoration(
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
    borderSide: BorderSide(color: Colors.grey),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
    borderSide: BorderSide(color: Colors.black, width: 2),
  ),
);

var DROP_DOWN_BUTTON_STYLE = ButtonStyleData(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8.0),
    border: Border.all(color: Colors.grey), // Border color
  ),
  padding: EdgeInsets.symmetric(horizontal: 10),
  height: 60,
  width: double.infinity,
);
