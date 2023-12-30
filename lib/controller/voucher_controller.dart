import 'dart:convert';

import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tkt_voucher/data/database_helper.dart';
import 'package:tkt_voucher/model/vo/voucher_vo.dart';
import 'package:tkt_voucher/page/home_page.dart';

class VoucherController extends GetxController {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  ScreenshotController screenshotController = ScreenshotController();
  var isConnected = false;

  @override
  Future<void> onInit() async {
    print('>>> Voucher init');
    super.onInit();
    isConnected = (await bluetoothPrint.isConnected)!;
  }

  @override
  void onReady() {
    print('>>> Voucher ready');
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void printVoucher(VoucherVO voucher) async {
    screenshotController
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

      //showCapturedWidget(context, capturedImage);
      var result = await DatabaseHelper().insertVoucher({
        'voucherNumber': voucher.voucherNumber,
        'dateAndTime': voucher.dateAndTime,
        'carNumber': voucher.carNumber,
        'fromTown': voucher.fromTown,
        'toTown': voucher.toTown,
        'sender': voucher.sender,
        'senderPhone': voucher.senderPhone,
        'receiver': voucher.receiver,
        'receiverPhone': voucher.receiverPhone,
        'type': voucher.type,
        'numberOfParcel': voucher.numberOfParcel,
        'charges': voucher.charges,
        'note': voucher.note,
        'cashAdvance': voucher.cashAdvance,
      });
      if (result != -1) {
        await bluetoothPrint.printLabel(config, list);
        Get.back(result: "success");
      } else {
        Get.back(result: "error");
        Get.snackbar("Error", "UnSuccess", backgroundColor: Colors.red);
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  void reprintVoucher(VoucherVO voucher) async {
    screenshotController
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
      if (isConnected) {
        await bluetoothPrint.printLabel(config, list);
        Get.back();
      } else {
        Get.snackbar("Warning", "Please connect Bluetooth");
      }
    }).catchError((onError) {
      print(onError);
    });
  }
}
