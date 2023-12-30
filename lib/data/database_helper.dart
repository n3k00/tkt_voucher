import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tkt_voucher/model/vo/voucher_vo.dart';

class DatabaseHelper {
  late Database _db;
  static const String tableName = "vouchers";
  final String createTableQuery = '''
      CREATE TABLE IF NOT EXISTS $tableName(
        id INTEGER PRIMARY KEY,
        voucherNumber TEXT,
        dateAndTime TEXT,
        carNumber TEXT,
        fromTown TEXT,
        toTown TEXT,
        sender TEXT,
        senderPhone TEXT,
        receiver TEXT,
        receiverPhone TEXT,
        type TEXT,
        numberOfParcel TEXT,
        charges TEXT,
        note TEXT,
        cashAdvance TEXT
      )
      ''';

  DatabaseHelper() {
    _createDatabase();
  }

  Future<Database?> _createDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, "vouchers.db");
    _db = await openDatabase(path);

    /// id name address phone email
    await _db.execute(createTableQuery);
    return _db;
  }

  Future<int?> insertVoucher(Map<String, dynamic> voucher) async {
    _db = (await _createDatabase())!;
    return await _db.insert(tableName, voucher);
  }

  Future<List<VoucherVO>> getAllVouchers() async {
    _db = (await _createDatabase())!;
    List<Map<String, dynamic>> result = await _db.query(
      tableName,
      columns: [
        'id',
        'voucherNumber',
        'dateAndTime',
        'carNumber',
        'fromTown',
        'toTown',
        'sender',
        'senderPhone',
        'receiver',
        'receiverPhone',
        'type',
        'numberOfParcel',
        'charges',
        'note',
        'cashAdvance',
      ],
    );

    List<VoucherVO> vouchers =
        result.map((map) => VoucherVO.fromMap(map)).toList();
    return vouchers;
  }

  Future<List<VoucherVO>> getVouchersByDate(String searchDate) async {
    _db = (await _createDatabase())!;
    List<Map<String, dynamic>> result = await _db.query(
      tableName,
      columns: [
        'id',
        'voucherNumber',
        'dateAndTime',
        'carNumber',
        'fromTown',
        'toTown',
        'sender',
        'senderPhone',
        'receiver',
        'receiverPhone',
        'type',
        'numberOfParcel',
        'charges',
        'note',
        'cashAdvance',
      ],
    );

    List<VoucherVO> vouchers =
        result.map((map) => VoucherVO.fromMap(map)).toList();

    // Filter vouchers based on the search date
    List<VoucherVO> filteredVouchers = vouchers
        .where((voucher) => voucher.dateAndTime.contains(searchDate))
        .toList();

    return filteredVouchers;
  }
}
