import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:tkt_voucher/model/vo/voucher_vo.dart';
import 'package:tkt_voucher/resource/strings.dart';
import 'package:tkt_voucher/widget/divider_dotted_line.dart';
import 'package:tkt_voucher/widget/item_detail.dart';
import 'package:tkt_voucher/widget/voucher_heading.dart';

class VoucherWidget extends StatelessWidget {
  final VoucherVO voucher;

  VoucherWidget({required this.voucher});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      width: 410,
      color: Colors.white,
      child: Column(
        children: [
          VoucherHeading(),
          SizedBox(height: 8),
          DividerDottedLine(),
          SizedBox(height: 8),
          // Transaction Information
          ItemDetail(
            title: TRANSACTION_ID,
            value: voucher.voucherNumber,
          ),
          SizedBox(height: 8),
          ItemDetail(
            title: TRANSACTION_DATE_AND_TIME,
            value: voucher.dateAndTime,
          ),
          SizedBox(height: 8),
          DividerDottedLine(),

          /// ကားအချက်အလက်
          SizedBox(height: 8),
          ItemDetail(title: CAR_NUMBER, value: voucher.carNumber),
          SizedBox(height: 8),
          ItemDetail(title: FROM, value: voucher.fromTown),
          SizedBox(height: 8),
          ItemDetail(title: TO, value: voucher.toTown),
          SizedBox(height: 8),
          DividerDottedLine(),

          /// ပိုင်ရှင်အချက်အလက်
          SizedBox(height: 8),
          ItemDetail(title: SENDER, value: voucher.sender),
          ItemDetail(value: voucher.senderPhone),
          SizedBox(height: 8),
          ItemDetail(title: RECEIVER, value: voucher.receiver),
          ItemDetail(value: voucher.receiverPhone),
          SizedBox(height: 8),
          DividerDottedLine(),

          /// ပစ္စည်းအချက်အလက်
          SizedBox(height: 8),
          ItemDetail(title: TYPE, value: voucher.type),
          SizedBox(height: 8),
          ItemDetail(title: NUMBER_OF_PARCEL, value: voucher.numberOfParcel),
          SizedBox(height: 8),
          DividerDottedLine(),

          /// ငွေကြေးအချက်အလက်
          SizedBox(height: 8),
          ItemDetail(title: CHARGES, value: voucher.charges),
          SizedBox(height: 8),
          ItemDetail(title: NOTE, value: voucher.note),
          SizedBox(height: 8),
          ItemDetail(
            title: CASH_ADVANCE,
            value: voucher.cashAdvance,
          ),
          SizedBox(height: 8),
          DividerDottedLine(),
          SizedBox(height: 8),
          BarcodeWidget(
            barcode: Barcode.code128(),
            data: voucher.voucherNumber,
            width: 200,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
