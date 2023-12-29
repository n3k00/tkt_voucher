import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tkt_voucher/resource/dimens.dart';
import 'package:tkt_voucher/resource/strings.dart';

class SettingsController extends GetxController {
  TextEditingController? addressController;
  TextEditingController? phonesController;
  TextEditingController? cityController;
  var cityList = <String>[].obs;

  var isLoading = false.obs;

  final box = GetStorage("settings");

  @override
  void onInit() {
    print('>>> SettingController init');
    try {
      isLoading(true);
      String address = box.read("address") ?? "";
      String phones = box.read("phones") ?? "";
      addressController = TextEditingController(text: address);
      phonesController = TextEditingController(text: phones);
      cityController = TextEditingController();
      fetchData();
    } finally {
      isLoading(false);
    }
    super.onInit();
  }

  void fetchData() {
    final dynamic tempTownList = box.read("townList");

    if (tempTownList != null && tempTownList is List<dynamic>) {
      final List<String> castedTownList = tempTownList.cast<String>().toList();
      cityList.assignAll(castedTownList);
    }

    print(cityList);
  }

  void editHeading() {
    if (addressController!.text.isNotEmpty &&
        phonesController!.text.isNotEmpty) {
      box.write("address", addressController!.text);
      box.write("phones", phonesController!.text);
      Get.defaultDialog(
        title: "Successful",
        content: Padding(
          padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
          child: Text("Edit is successful"),
        ),
        onConfirm: () {
          Get.back();
        },
      );
    } else {
      Get.defaultDialog(
        title: "Warning",
        content: Padding(
          padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
          child: Text(WARNING_TEXT_FOR_SETTING_PAGE),
        ),
        onConfirm: () {
          Get.back();
        },
      );
    }
  }

  void addCity() {
    if (cityController!.text.isNotEmpty) {
      cityList.add(cityController!.text);
      cityList.refresh();
      box.write("townList", cityList);
      /*List<String> tempCityList = box.read<List<String>>("townList") ?? [];
      print("temp $tempCityList");*/
      cityController!.text = "";
      Get.back();
      Get.snackbar("Confirm", "Successful");
    } else {
      Get.back();
    }
  }
}
