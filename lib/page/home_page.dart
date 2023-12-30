import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tkt_voucher/controller/home_controller.dart';
import 'package:tkt_voucher/resource/constant.dart';
import 'package:tkt_voucher/resource/dimens.dart';
import 'package:tkt_voucher/resource/strings.dart';
import 'package:tkt_voucher/widget/drop_down_hint.dart';
import 'package:tkt_voucher/widget/main_drawer.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    controller.getListData();
    controller.checkConnect();
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed("/home/connect");
            },
            icon: Obx(
              () => Icon(
                controller.isConnected.value
                    ? Icons.bluetooth_connected_outlined
                    : Icons.bluetooth,
                color: controller.isConnected.value ? Colors.blue : null,
              ),
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MARGIN_MEDIUM),
          child: Form(
            key: controller.key,
            child: Column(
              children: [
                /// ကားနံပါတ်
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: INPUT_TEXT_FIELD_STYLE.copyWith(
                    hintText: CAR_NUMBER,
                    prefixIcon: Icon(
                      FontAwesomeIcons.car,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "$CAR_NUMBER ကို ရိုက်ထည့်ပါ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.carNumber.value = value!;
                  },
                ),
                SizedBox(height: MARGIN_MEDIUM_2),
                Row(
                  children: [
                    /// ပို့သည့်မြို့
                    Expanded(
                      child: Obx(
                        () => DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            value: controller.fromTownSelected.value,
                            items: controller.townList
                                .map(
                                  (String item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  ),
                                )
                                .toList(),
                            onChanged: (String? value) {
                              controller.fromTownSelected.value = value!;
                            },
                            buttonStyleData: DROP_DOWN_BUTTON_STYLE,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: MARGIN_MEDIUM_2),

                    /// လက်ခံမည့်မြို့
                    Expanded(
                      child: Obx(
                        () => DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: DropDownText(
                              hintText: TO_TOWN,
                              prefixIcon: FontAwesomeIcons.city,
                            ),
                            value: controller.toTownSelected.value,
                            items: controller.townList
                                .map(
                                  (String item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  ),
                                )
                                .toList(),
                            onChanged: (String? value) {
                              print(value);
                              controller.toTownSelected.value = value!;
                            },
                            buttonStyleData: DROP_DOWN_BUTTON_STYLE,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MARGIN_MEDIUM_2),

                /// ပို့သူ
                TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: INPUT_TEXT_FIELD_STYLE.copyWith(
                    hintText: SENDER,
                    prefixIcon: Icon(FontAwesomeIcons.user),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "$SENDER ကို ရိုက်ထည့်ပါ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.sender.value = value!;
                  },
                ),
                SizedBox(height: MARGIN_MEDIUM_2),

                /// ပို့သူ ဖုန်း
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: INPUT_TEXT_FIELD_STYLE.copyWith(
                    hintText: SENDER_PHONE,
                    prefixIcon: Icon(FontAwesomeIcons.phone),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "$SENDER_PHONE ကို ရိုက်ထည့်ပါ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.senderPhone.value = value!;
                  },
                ),
                SizedBox(height: MARGIN_MEDIUM_2),

                /// လက်ခံသူ
                TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: INPUT_TEXT_FIELD_STYLE.copyWith(
                    hintText: RECEIVER,
                    prefixIcon: Icon(FontAwesomeIcons.user),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "$RECEIVER ကို ရိုက်ထည့်ပါ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.receiver.value = value!;
                  },
                ),
                SizedBox(height: MARGIN_MEDIUM_2),

                /// လက်ခံသူ ဖုန်းနံပါတ်
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: INPUT_TEXT_FIELD_STYLE.copyWith(
                    hintText: RECEIVER_PHONE,
                    prefixIcon: Icon(FontAwesomeIcons.phone),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "$RECEIVER_PHONE ကို ရိုက်ထည့်ပါ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.receiverPhone.value = value!;
                  },
                ),
                SizedBox(height: MARGIN_MEDIUM_2),

                /// အမျိုးအစား
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: INPUT_TEXT_FIELD_STYLE.copyWith(
                    hintText: TYPE,
                    prefixIcon: Icon(FontAwesomeIcons.boxOpen),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "$TYPE ကို ရိုက်ထည့်ပါ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.type.value = value!;
                  },
                ),
                SizedBox(height: MARGIN_MEDIUM_2),

                /// အရေအတွက်
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: INPUT_TEXT_FIELD_STYLE.copyWith(
                    hintText: NUMBER_OF_PARCEL,
                    prefixIcon: Icon(FontAwesomeIcons.listOl),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "$NUMBER_OF_PARCEL ကို ရိုက်ထည့်ပါ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.number.value = value!;
                  },
                ),
                SizedBox(height: MARGIN_MEDIUM_2),

                /// ကျသင့်ငွေ
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: INPUT_TEXT_FIELD_STYLE.copyWith(
                    hintText: CHARGES,
                    prefixIcon: Icon(FontAwesomeIcons.dollarSign),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "$CHARGES ကို ရိုက်ထည့်ပါ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.charges.value = value!;
                  },
                ),
                SizedBox(height: MARGIN_MEDIUM_2),

                /// မှတ်ချက်
                Obx(
                  () => DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      value: controller.selectedNote.value,
                      items: controller.noteList
                          .map(
                            (String item) => DropdownMenuItem(
                              value: item,
                              child: DropDownText(
                                hintText: item,
                                prefixIcon: FontAwesomeIcons.message,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (String? value) {
                        controller.selectedNote.value = value!;
                      },
                      buttonStyleData: DROP_DOWN_BUTTON_STYLE,
                    ),
                  ),
                ),
                SizedBox(height: MARGIN_MEDIUM_2),

                /// စိုက်ငွေ
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: INPUT_TEXT_FIELD_STYLE.copyWith(
                    hintText: CASH_ADVANCE,
                    prefixIcon: Icon(
                      FontAwesomeIcons.handHoldingDollar,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "$CASH_ADVANCE ကို ရိုက်ထည့်ပါ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.cashAdvance.value = value!;
                  },
                ),
                SizedBox(height: MARGIN_MEDIUM_2),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
                  ),
                  child: MaterialButton(
                    onPressed: controller.prepareVoucher,
                    minWidth: double.infinity,
                    child: Text("OK"),
                  ),
                ),
                SizedBox(height: MARGIN_MEDIUM_2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
