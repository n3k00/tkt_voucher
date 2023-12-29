import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tkt_voucher/controller/settings_controller.dart';
import 'package:tkt_voucher/resource/constant.dart';
import 'package:tkt_voucher/resource/dimens.dart';

class EditHeadingPage extends StatelessWidget {
  final SettingsController controller = Get.put(SettingsController());
  @override
  Widget build(BuildContext context) {
    controller.fetchData();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Heading"),
      ),
      body: controller.isLoading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(MARGIN_MEDIUM),
              child: Column(
                children: [
                  /// Address
                  TextField(
                    controller: controller.addressController,
                    maxLines: 3,
                    decoration: INPUT_TEXT_FIELD_STYLE.copyWith(),
                  ),
                  SizedBox(height: MARGIN_MEDIUM_2),

                  /// Phone
                  TextField(
                    controller: controller.phonesController,
                    maxLines: 3,
                    decoration: INPUT_TEXT_FIELD_STYLE.copyWith(),
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
                    ),
                    child: MaterialButton(
                      onPressed: controller.editHeading,
                      minWidth: double.infinity,
                      child: Text(
                        "Edit",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: MARGIN_MEDIUM_2),
                ],
              ),
            ),
    );
  }
}
