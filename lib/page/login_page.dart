import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tkt_voucher/controller/login_controller.dart';
import 'package:tkt_voucher/resource/constant.dart';
import 'package:tkt_voucher/resource/dimens.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => ModalProgressHUD(
            inAsyncCall: controller.isLoading.value,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: MARGIN_MEDIUM_2, vertical: MARGIN_MEDIUM_2),
                child: Column(
                  children: [
                    SizedBox(height: MARGIN_XLARGE),
                    Image.asset(
                      "assets/images/logo.jpg",
                      width: LOGO_WIDTH,
                    ),
                    SizedBox(height: MARGIN_XLARGE),
                    Form(
                      key: controller.loginKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: INPUT_TEXT_FIELD_STYLE.copyWith(
                              hintText: "Email",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Email ကိုဖြည့်ပါ။";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              controller.email.value = value!;
                            },
                          ),
                          SizedBox(height: MARGIN_MEDIUM_2),
                          TextFormField(
                            obscureText: true,
                            decoration: INPUT_TEXT_FIELD_STYLE.copyWith(
                              hintText: "Password",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password ကို ဖြည့်ပါ။";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              controller.password.value = value!;
                            },
                          ),
                          SizedBox(height: MARGIN_MEDIUM_2),
                          ElevatedButton(
                            onPressed: controller.login,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
