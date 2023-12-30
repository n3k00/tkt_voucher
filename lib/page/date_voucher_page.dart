import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tkt_voucher/controller/receipts_controller.dart';
import 'package:tkt_voucher/data/database_helper.dart';
import 'package:tkt_voucher/model/vo/voucher_vo.dart';

class DateVoucherPage extends StatelessWidget {
  final ReceiptsController controller = Get.put(ReceiptsController());
  final String searchDate = Get.arguments[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Date of $searchDate"),
      ),
      body: FutureBuilder<List<VoucherVO>>(
        future: DatabaseHelper().getVouchersByDate(searchDate),
        builder:
            (BuildContext context, AsyncSnapshot<List<VoucherVO>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                VoucherVO voucher = snapshot.data![index];
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
      ),
    );
  }
}
