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
}
