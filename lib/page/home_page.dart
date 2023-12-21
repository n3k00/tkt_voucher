import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tkt_voucher/controller/home_controller.dart';
import 'package:tkt_voucher/widget/main_drawer.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed("/home/connect");
            },
            icon: Icon(Icons.bluetooth),
          ),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
