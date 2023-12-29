import 'dart:convert';

import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sks_ticket_view/sks_ticket_view.dart';
import 'package:tkt_voucher/controller/voucher_controller.dart';
import 'package:tkt_voucher/model/vo/voucher_vo.dart';
import 'package:tkt_voucher/resource/dimens.dart';
import 'package:tkt_voucher/widget/voucher_widget.dart';

class VoucherPage extends StatelessWidget {
  final VoucherController controller = Get.put(VoucherController());
  VoucherVO voucher = Get.arguments[0];
  String address = Get.arguments[1];
  String phones = Get.arguments[2];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Voucher"),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Screenshot(
                      controller: controller.screenshotController,
                      child: SKSTicketView(
                        triangleAxis: Axis.vertical,
                        child: VoucherWidget(
                          voucher: voucher,
                          address: address,
                          phones: phones,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: MARGIN_MEDIUM_3,
            right: MARGIN_MEDIUM_10,
            left: MARGIN_MEDIUM_10,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
              ),
              child: MaterialButton(
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
                    /*list.add(LineText(
                        type: LineText.TYPE_BARCODE,
                        content: voucher.voucherNumber,
                        align: LineText.ALIGN_CENTER,
                        linefeed: 1));*/

                    list.add(LineText(linefeed: 1));
                    list.add(LineText(linefeed: 1));

                    //showCapturedWidget(context, capturedImage);
                    await controller.bluetoothPrint.printLabel(config, list);
                  }).catchError((onError) {
                    print(onError);
                  });
                },
                child: Text(
                  'Print',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
