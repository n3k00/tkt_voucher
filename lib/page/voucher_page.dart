import 'dart:convert';

import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sks_ticket_view/sks_ticket_view.dart';
import 'package:tkt_voucher/controller/voucher_controller.dart';
import 'package:tkt_voucher/resource/dimens.dart';
import 'package:tkt_voucher/resource/strings.dart';
import 'package:tkt_voucher/widget/divider_dotted_line.dart';
import 'package:tkt_voucher/widget/item_detail.dart';
import 'package:tkt_voucher/widget/voucher_heading.dart';

class VoucherPage extends StatelessWidget {
  final VoucherController controller = Get.put(VoucherController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Voucher"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Screenshot(
                  controller: controller.screenshotController,
                  child: SKSTicketView(
                    triangleAxis: Axis.vertical,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      width: 410,
                      color: Colors.white,
                      child: Column(
                        children: [
                          VoucherHeading(),
                          SizedBox(height: 8),
                          DividerDottedLine(),
                          SizedBox(height: 8),
                          // Transaction Information
                          ItemDetail(
                            title: TRANSACTION_ID,
                            value: "23102100039",
                          ),
                          SizedBox(height: 8),
                          ItemDetail(
                            title: TRANSACTION_DATE_AND_TIME,
                            value: DateTime.now().toString(),
                          ),
                          SizedBox(height: 8),
                          DividerDottedLine(),

                          /// ကားအချက်အလက်
                          SizedBox(height: 8),
                          ItemDetail(title: CAR_NUMBER, value: "GG4665"),
                          SizedBox(height: 8),
                          ItemDetail(title: "လားရှိုး", value: FROM),
                          SizedBox(height: 8),
                          ItemDetail(title: "လွိုင်လင်", value: TO),
                          SizedBox(height: 8),
                          DividerDottedLine(),

                          /// ပိုင်ရှင်အချက်အလက်
                          SizedBox(height: 8),
                          ItemDetail(title: SENDER, value: "ဦးကျော်မိုး"),
                          ItemDetail(value: "09429363127"),
                          SizedBox(height: 8),
                          ItemDetail(title: RECEIVER, value: "ဝေနှင်းမိုး"),
                          ItemDetail(value: "09428366344"),
                          SizedBox(height: 8),
                          DividerDottedLine(),

                          /// ပစ္စည်းအချက်အလက်
                          SizedBox(height: 8),
                          ItemDetail(title: TYPE, value: "ဂျပ်ဖာ"),
                          SizedBox(height: 8),
                          ItemDetail(title: NUMBER_OF_PARCEL, value: "1"),
                          SizedBox(height: 8),
                          DividerDottedLine(),

                          /// ငွေကြေးအချက်အလက်
                          SizedBox(height: 8),
                          ItemDetail(title: CHARGES, value: "5000"),
                          SizedBox(height: 8),
                          ItemDetail(title: NOTE, value: "တန်ဆာခ မရှင်းရသေး"),
                          SizedBox(height: 8),
                          ItemDetail(title: CASH_ADVANCE),
                          SizedBox(height: 8),
                          DividerDottedLine(),

                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              child: Text(
                'Capture Above Widget',
              ),
              onPressed: () {
                controller.screenshotController
                    .capture(delay: Duration(milliseconds: 10))
                    .then((capturedImage) async {
                  Map<String, dynamic> config = {};
                  List<LineText> list = [];

                  List<int> imageBytes = capturedImage!.toList();
                  String base64Image = base64Encode(imageBytes);

                  list.add(LineText(
                    type: LineText.TYPE_IMAGE,
                    width: (74 * 8).toInt(), // Convert width to dots
                    content: base64Image,
                    align: LineText.ALIGN_CENTER,
                    linefeed: 1, // Add linefeed for separation
                  ));
                  list.add(LineText(
                      type: LineText.TYPE_TEXT,
                      content: 'Your text goes here...',
                      align: LineText.ALIGN_CENTER,
                      linefeed: 1));

                  list.add(LineText(linefeed: 1));
                  list.add(LineText(linefeed: 1));

                  //showCapturedWidget(context, capturedImage);
                  await controller.bluetoothPrint.printLabel(config, list);
                }).catchError((onError) {
                  print(onError);
                });
              },
            ),
            OutlinedButton(
              onPressed: () async {
                Map<String, dynamic> config = Map();
                List<LineText> list = [];
                list.add(LineText(
                    type: LineText.TYPE_TEXT,
                    content: 'A Title',
                    weight: 3,
                    align: LineText.ALIGN_CENTER,
                    linefeed: 1));
                list.add(LineText(
                    type: LineText.TYPE_TEXT,
                    content: 'this is left',
                    weight: 0,
                    align: LineText.ALIGN_LEFT,
                    linefeed: 2));
                list.add(LineText(
                    type: LineText.TYPE_TEXT,
                    content: 'this is right',
                    align: LineText.ALIGN_RIGHT,
                    linefeed: 0));
                list.add(LineText(linefeed: 1));
                list.add(LineText(
                    type: LineText.TYPE_BARCODE,
                    content: 'A12312112',
                    size: 10,
                    align: LineText.ALIGN_CENTER,
                    linefeed: 1));
                list.add(LineText(linefeed: 1));
                list.add(LineText(
                    type: LineText.TYPE_QRCODE,
                    content: 'facebook.com',
                    size: 10,
                    align: LineText.ALIGN_CENTER,
                    linefeed: 1));
                list.add(LineText(linefeed: 1));

                await controller.bluetoothPrint.printReceipt(config, list);
              },
              child: Text('print receipt(esc)'),
            ),
          ],
        ),
      ),
    );
  }

  Widget textRow() {
    return Row(
      children: [
        Container(
          //width: MediaQuery.of(context).size.width / 4,
          child: Text(
            TRANSACTION_ID,
            style: TextStyle(
              fontSize: MARGIN_MEDIUM_2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(width: MARGIN_CARD_MEDIUM_2),
        Expanded(
          child: Text(
            "23102100039",
            style: TextStyle(
              color: Colors.white,
              fontSize: MARGIN_MEDIUM_2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
