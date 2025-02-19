import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class AppDb {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE places(id TEXT PRIMARY KEY,title TEXT,image TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await AppDb.database();
    int id = await db.rawInsert(
      'INSERT INTO places(id, title, image) VALUES(?, ?, ?)',
      [data['id'], data['title'], data['image']],
    );
    // print('id: $id');
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await AppDb.database();
    return db.query(table);
  }
}
