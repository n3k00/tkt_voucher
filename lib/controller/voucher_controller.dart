import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

class VoucherController extends GetxController {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void onInit() {
    print('>>> Voucher init');

    super.onInit();
  }

  @override
  void onReady() {
    print('>>> Voucher ready');
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
