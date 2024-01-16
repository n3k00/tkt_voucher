import 'package:firebase_auth/firebase_auth.dart';
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
              color: Colors.green,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  FirebaseAuth.instance.currentUser?.email ?? "",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            tileColor: Get.currentRoute == '/home' ? Colors.grey[300] : null,
            onTap: () {
              print(Get.currentRoute);
              Get.back();
              Get.offNamed('/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.receipt),
            title: Text('Receipts'),
            tileColor:
                Get.currentRoute == '/receipts' ? Colors.grey[300] : null,
            onTap: () {
              Get.back();
              Get.offNamed('/receipts');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            tileColor:
                Get.currentRoute == '/settings' ? Colors.grey[300] : null,
            onTap: () {
              Get.back();
              Get.offNamed('/settings');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout_outlined),
            title: Text('Logout'),
            tileColor: Get.currentRoute == '/logout' ? Colors.grey[300] : null,
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Get.offNamed('/login');
            },
          ),
        ],
      ),
    );
  }
}
