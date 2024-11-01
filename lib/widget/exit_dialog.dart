import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:tkt_voucher/resource/dimens.dart';
import 'package:tkt_voucher/resource/strings.dart';

Future<bool> exitDialog(context) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: EXIT_DIALOG_HEIGHT,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(EXTI_TITLE),
                SizedBox(height: MARGIN_MEDIUM_3),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: Text("No"),
                        onPressed: () {
                          print("selected NO");
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        child: Text("YES"),
                        onPressed: () {
                          print("selected YES");
                          exit(0);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
