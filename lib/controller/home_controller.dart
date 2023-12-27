import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  GlobalKey<FormState> key = GlobalKey();
  RxString carNumber = RxString('');
  RxString sender = RxString('');
  RxString senderPhone = RxString('');
  RxString receiver = RxString('');
  RxString receiverPhone = RxString('');
  RxString type = RxString('');
  RxString number = RxString('');
  RxString charges = RxString('');
  RxString cashAdvance = RxString('');

  var note = <String>[].obs;

  @override
  void onInit() {
    print('>>> HomeController init');
    super.onInit();
    fetchData();
  }

  @override
  void onReady() {
    print('>>> HomeController ready');
    super.onReady();
  }

  void fetchData() {}

  void prepareVoucher() {
    //Get.to(VoucherPage());
    if (key.currentState!.validate()) {
      key.currentState!.save();
      print(carNumber);
      print(receiverPhone);
      // Add other values here
    }
  }
}
