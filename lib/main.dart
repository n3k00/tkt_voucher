import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tkt_voucher/controller/home_controller.dart';
import 'package:tkt_voucher/controller/receipts_controller.dart';
import 'package:tkt_voucher/controller/settings_controller.dart';
import 'package:tkt_voucher/controller/voucher_controller.dart';
import 'package:tkt_voucher/page/connect_page.dart';
import 'package:tkt_voucher/page/home_page.dart';
import 'package:tkt_voucher/page/receipts_page.dart';
import 'package:tkt_voucher/page/settings_page.dart';
import 'package:tkt_voucher/page/voucher_page.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TKT Voucher',
      navigatorKey: Get.key,
      initialRoute: "/home",
      getPages: [
        GetPage(
          name: "/home",
          page: () => HomePage(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: "/receipts",
          page: () => ReceiptsPage(),
          binding: ReceiptsBinding(),
        ),
        GetPage(
          name: "/settings",
          page: () => SettingsPage(),
          binding: SettingsBinding(),
        ),
        GetPage(
          name: "/home/connect",
          page: () => ConnectPage(),
        ),
        GetPage(
          name: "/home/voucher",
          page: () => VoucherPage(),
        ),
      ],
    );
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(), permanent: true);
  }
}

class ReceiptsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReceiptsController());
  }
}

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController());
  }
}
