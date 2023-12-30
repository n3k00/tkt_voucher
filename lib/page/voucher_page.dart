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
  bool reprint = Get.arguments[3];
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
                  if (reprint) {
                    controller.reprintVoucher(voucher);
                  } else {
                    controller.printVoucher(voucher);
                  }
                },
                child: Text(
                  reprint ? 'Reprint' : "Print",
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
