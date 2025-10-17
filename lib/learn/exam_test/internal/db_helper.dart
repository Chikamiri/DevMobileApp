import 'package:sqflite/sqflite.dart';
import 'db.dart'; // LibraryDB

class DBHelper {
  // ======== USER AUTH ========
  static Future<void> initUserTable() async {
    final db = await LibraryDB.database;
    await db.execute('''
      CREATE TABLE IF NOT EXISTS users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE,
        password TEXT
      )
    ''');
  }

  static Future<int> insertUser(String username, String password) async {
    final db = await LibraryDB.database;
    await initUserTable();
    return await db.insert('users', {
      'username': username,
      'password': password,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<Map<String, dynamic>?> getUser(
    String username,
    String password,
  ) async {
    final db = await LibraryDB.database;
    await initUserTable();
    final result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
      limit: 1,
    );
    return result.isEmpty ? null : result.first;
  }

  static Future<Map<String, dynamic>?> getUserByName(String username) async {
    final db = await LibraryDB.database;
    await initUserTable();
    final result = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
      limit: 1,
    );
    return result.isEmpty ? null : result.first;
  }

  static Future<int> deleteUser(String username) async {
    final db = await LibraryDB.database;
    await initUserTable();
    return await db.delete(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );
  }

  static Future<int> update(
    String table,
    Map<String, dynamic> data,
    int id,
  ) async {
    final db = await LibraryDB.database;
    return await db.update(table, data, where: 'id = ?', whereArgs: [id]);
  }

  // ======== CRUD CHUNG (Books, Members, Records...) ========
  static Future<int> insert(String table, Map<String, dynamic> data) async {
    return await LibraryDB.insert(table, data);
  }

  static Future<List<Map<String, dynamic>>> query(String table) async {
    return await LibraryDB.getAll(table);
  }

  static Future<int> delete(String table, int id) async {
    return await LibraryDB.delete(table, id);
  }
}
