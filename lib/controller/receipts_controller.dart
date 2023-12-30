import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:tkt_voucher/data/database_helper.dart';
import 'package:tkt_voucher/model/vo/voucher_vo.dart';
import 'package:tkt_voucher/resource/strings.dart';

class ReceiptsController extends GetxController {
  final searchPhone = Rx<String>('');
  final vouchers = RxList<VoucherVO>([]);
  String address = '';
  String phones = '';
  final box = GetStorage("settings");

  @override
  void onInit() {
    print('>>> ReceiptController init');
    super.onInit();
    getListData();
  }

  void getListData() async {
    /// get voucher heading data
    box.writeIfNull("address", ADDRESS_STRING);
    address = box.read("address") ?? "";

    box.writeIfNull("phones", PHONES_STRING);
    phones = box.read("phones") ?? "";

    /// get list data
    List<VoucherVO> allVouchers = await DatabaseHelper().getAllVouchers();
    vouchers.assignAll(allVouchers);
  }

  void searchQuery(String query) {
    searchPhone.value = query;
  }

  List<VoucherVO> filteredVouchers() {
    List<VoucherVO> filteredList = vouchers
        .where((voucher) => voucher.receiverPhone.contains(searchPhone.value))
        .toList();
    return filteredList.reversed.toList();
  }

  void toPrint(voucher) {
    Get.toNamed("/home/voucher", arguments: [voucher, address, phones, true]);
  }

  void selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023), // - not to allow to choose before today.
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      Get.toNamed("/receipts/date", arguments: [formattedDate]);
    } else {
      print("Date is not selected");
    }
  }
}
