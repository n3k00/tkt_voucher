import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tkt_voucher/controller/receipts_controller.dart';
import 'package:tkt_voucher/widget/main_drawer.dart';

class ReceiptsPage extends GetView<ReceiptsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Receipts"),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Text(controller.title),
      ),
    );
  }
}
