import 'package:flutter/material.dart';

class VoucherHeading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1)),
      child: Column(
        children: [
          Text(
            "သိင်္ခသူ ခရီးသည် ပို့ဆောင်ရေး",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          //address
          Text(
            '41 ဂိတ်၊ နှစ်ထပ်တိုက်တန်းရှေ့၊ ရပ်ကွက်(၄)၊ လားရှိုးမြို့',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          //phone
          Text(
            'Ph - 09429363127, 09250787547, 09666628053',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
