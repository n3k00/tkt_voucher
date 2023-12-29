import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tkt_voucher/controller/settings_controller.dart';
import 'package:tkt_voucher/widget/add_city.dart';

class EditCitiesPage extends StatelessWidget {
  final SettingsController controller = Get.put(SettingsController());
  @override
  Widget build(BuildContext context) {
    controller.fetchData();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Cities"),
      ),
      body: controller.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : Obx(
              () => ListView.separated(
                itemCount: controller.cityList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(controller.cityList[index]),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => SingleChildScrollView(
              child: AddCity(),
            ),
          );
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),
    );
  }
}
