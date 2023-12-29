import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tkt_voucher/controller/settings_controller.dart';
import 'package:tkt_voucher/widget/main_drawer.dart';

class SettingsPage extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      drawer: MainDrawer(),
      body: ListView(
        children: [
          ListTile(
            title: Text("Edit Voucher Heading"),
            trailing: Icon(Icons.chevron_right_outlined),
            onTap: () {
              Get.toNamed("/settings/edit_heading");
            },
          ),
          Divider(),
          ListTile(
            title: Text("Edit City List"),
            trailing: Icon(Icons.chevron_right_outlined),
            onTap: () {
              Get.toNamed("/settings/edit_cities");
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
