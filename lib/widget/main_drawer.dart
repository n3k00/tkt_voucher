import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(Get.currentRoute);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: Text('Home'),
            tileColor: Get.currentRoute == '/home' ? Colors.grey[300] : null,
            onTap: () {
              print(Get.currentRoute);
              Get.back();
              Get.offNamed('/home');
            },
          ),
          ListTile(
            title: Text('Receipts'),
            tileColor:
                Get.currentRoute == '/receipts' ? Colors.grey[300] : null,
            onTap: () {
              Get.back();
              Get.offNamed('/receipts');
            },
          ),
          ListTile(
            title: Text('Settings'),
            tileColor:
                Get.currentRoute == '/settings' ? Colors.grey[300] : null,
            onTap: () {
              Get.back();
              Get.offNamed('/settings');
            },
          ),
        ],
      ),
    );
  }
}
