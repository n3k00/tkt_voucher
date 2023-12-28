import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tkt_voucher/model/vo/voucher_vo.dart';
import 'package:tkt_voucher/resource/dimens.dart';
import 'package:tkt_voucher/resource/strings.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  var isConnected = false.obs;

  GlobalKey<FormState> key = GlobalKey();
  RxString carNumber = RxString('');
  RxString sender = RxString('');
  RxString senderPhone = RxString('');
  RxString receiver = RxString('');
  RxString receiverPhone = RxString('');
  RxString type = RxString('');
  RxString number = RxString('');
  RxString charges = RxString('');
  RxString selectedNote = RxString('');
  RxString cashAdvance = RxString('');
  RxString fromTownSelected = RxString('');
  RxString toTownSelected = RxString('');

  final box = GetStorage("settings");

  var noteList = <String>[].obs;
  var townList = <String>[].obs;

  @override
  void onInit() {
    print('>>> HomeController init');
    super.onInit();
    getListData();
  }

  @override
  void onReady() {
    print('>>> HomeController ready');
    super.onReady();
  }

  void getListData() {
    /// for note List
    box.writeIfNull("noteList", NOTE_LIST);
    List<dynamic>? tempNoteList = box.read("noteList");
    if (tempNoteList != null && tempNoteList is List<String>) {
      noteList.assignAll(tempNoteList);
      selectedNote.value = noteList.first;
    }

    /// for town list
    box.writeIfNull("townList", TOWN_LIST);
    List<dynamic>? tempTownList = box.read("townList");
    if (tempTownList != null && tempTownList is List<String>) {
      townList.assignAll(tempTownList);
      fromTownSelected.value = townList.first;
      toTownSelected.value = townList[1];
    }
  }

  void prepareVoucher() {
    if (key.currentState!.validate() &&
        toTownSelected.value != fromTownSelected.value) {
      key.currentState!.save();
      String voucherNumber = generateVoucherNumber();
      String dateAndTime = generateDateAndTime();
      VoucherVO voucherVO = VoucherVO(
        voucherNumber: voucherNumber,
        dateAndTime: dateAndTime,
        carNumber: carNumber.value,
        fromTown: fromTownSelected.value,
        toTown: toTownSelected.value,
        sender: sender.value,
        senderPhone: senderPhone.value,
        receiver: receiver.value,
        receiverPhone: receiverPhone.value,
        type: type.value,
        numberOfParcel: number.value,
        charges: charges.value,
        note: selectedNote.value,
        cashAdvance: cashAdvance.value,
      );
      Get.toNamed("/home/voucher", arguments: [voucherVO]);
      // Add other values here
    } else {
      Get.defaultDialog(
        title: "Warning",
        content: Padding(
          padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
          child: Text(WARNING_TEXT),
        ),
        onConfirm: () {
          Get.back();
        },
      );
    }
  }

  String generateVoucherNumber() {
    final DateTime now = DateTime.now();
    final String voucherNumber = DateFormat('MMddHHmmssSSS').format(now);
    return voucherNumber;
  }

  String generateDateAndTime() {
    DateTime now = DateTime.now();
    String dateAndTime = DateFormat('dd-MM-yyyy HH:mm').format(now);
    return dateAndTime;
  }

  void checkConnect() async {
    var check = await bluetoothPrint.isConnected;
    isConnected(check);
  }
}
