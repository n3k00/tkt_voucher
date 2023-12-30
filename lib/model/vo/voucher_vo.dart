class VoucherVO {
  String voucherNumber;
  String dateAndTime;
  String carNumber;
  String fromTown;
  String toTown;
  String sender;
  String senderPhone;
  String receiver;
  String receiverPhone;
  String type;
  String numberOfParcel;
  String charges;
  String note;
  String cashAdvance;

  VoucherVO(
      {required this.voucherNumber,
      required this.dateAndTime,
      required this.carNumber,
      required this.fromTown,
      required this.toTown,
      required this.sender,
      required this.senderPhone,
      required this.receiver,
      required this.receiverPhone,
      required this.type,
      required this.numberOfParcel,
      required this.charges,
      required this.note,
      required this.cashAdvance});

  Map<String, dynamic> insertVoucher({
    required voucherNumber,
    required dateAndTime,
    required carNumber,
    required fromTown,
    required toTown,
    required sender,
    required senderPhone,
    required receiver,
    required receiverPhone,
    required type,
    required numberOfParcel,
    required charges,
    required note,
    required cashAdvance,
  }) {
    return {
      'voucherNumber': voucherNumber,
      'dateAndTime': dateAndTime,
      'carNumber': carNumber,
      'fromTown': fromTown,
      'toTown': toTown,
      'sender': sender,
      'senderPhone': senderPhone,
      'receiver': receiver,
      'receiverPhone': receiverPhone,
      'type': type,
      'numberOfParcel': numberOfParcel,
      'charges': charges,
      'note': note,
      'cashAdvance': cashAdvance,
    };
  }

  factory VoucherVO.fromMap(Map<String, dynamic> map) {
    return VoucherVO(
      voucherNumber: map['voucherNumber'],
      dateAndTime: map['dateAndTime'],
      carNumber: map['carNumber'],
      fromTown: map['fromTown'],
      toTown: map['toTown'],
      sender: map['sender'],
      senderPhone: map['senderPhone'],
      receiver: map['receiver'],
      receiverPhone: map['receiverPhone'],
      type: map['type'],
      numberOfParcel: map['numberOfParcel'],
      charges: map['charges'],
      note: map['note'],
      cashAdvance: map['cashAdvance'],
    );
  }
}
