import 'package:bytebank_v2/database/dao/contact_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'bank.db');

  return openDatabase(path, onCreate: (db, version) {
    db.execute(ContactDao.tableSql);
  }, version: 1);
}

// Future<Database> getDatabase() async {
  // return getDatabasesPath().then((dbPath) {
  //   final String path = join(dbPath, 'bank.db');
  //   return openDatabase(path, onCreate: (db, version) {
  //     db.execute('CREATE TABLE contacts('
  //         'id INTEGER PRIMARY KEY, '
  //         'name TEXT, '
  //         'account_number INTEGER)');
  //   }, version: 1);
  // });
// }
