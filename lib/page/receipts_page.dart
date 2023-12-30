import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tkt_voucher/controller/receipts_controller.dart';
import 'package:tkt_voucher/data/database_helper.dart';
import 'package:tkt_voucher/model/vo/voucher_vo.dart';
import 'package:tkt_voucher/resource/constant.dart';
import 'package:tkt_voucher/widget/main_drawer.dart';

class ReceiptsPage extends GetView<ReceiptsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Receipts"),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.phone,
              decoration: INPUT_TEXT_FIELD_STYLE.copyWith(
                hintText: "Search",
                prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass),
              ),
              onChanged: (value) {
                print(value);
                controller.searchQuery(value);
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              var _ = controller.searchPhone.value;
              return FutureBuilder<List<VoucherVO>>(
                future: DatabaseHelper().getAllVouchers(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<VoucherVO>> snapshot) {
                  if (snapshot.hasData) {
                    List<VoucherVO> filteredList =
                        controller.filteredVouchers();
                    return ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        VoucherVO voucher = filteredList[index];
                        return Card(
                          child: ListTile(
                            leading: Icon(FontAwesomeIcons.ticket),
                            title: Text(
                              voucher.receiver,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(voucher.receiverPhone),
                                Text(voucher.dateAndTime)
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                controller.toPrint(voucher);
                              },
                              icon: Icon(Icons.chevron_right_outlined),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else if (!snapshot.hasData) {
                    return Center(child: Text("Voucher တစ်ခုမှ မရှိသေးပါ။"));
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          controller.selectDate();
        },
        child: Icon(Icons.date_range),
      ),
    );
  }
}
