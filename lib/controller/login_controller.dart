import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> loginKey = GlobalKey();
  RxString email = RxString("");
  RxString password = RxString("");
  RxBool isLoading = false.obs;

  void login() async {
    if (loginKey.currentState!.validate()) {
      loginKey.currentState!.save();
      isLoading.value = true;
      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.value,
          password: password.value,
        );
        isLoading.value = false;
        Get.offAndToNamed("/home");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          isLoading.value = false;
          Get.snackbar("Warning", "No user found for that email.");
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          isLoading.value = false;
          Get.snackbar("Warning", "Wrong password provided for that user.");
        }
        isLoading.value = false;
      }
      /* var result = await Get.toNamed("/home/voucher",
          arguments: [voucherVO, address, phones, false]);
      print("home $result");
      if (result == "success") {
        key.currentState?.reset();
      }*/
    }
  }
}
