import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class VoucherHeading extends StatelessWidget {
  final String address;
  final String phones;
  VoucherHeading({required this.address, required this.phones});

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
            address,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          //phone
          Text(
            "Ph - $phones",
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
