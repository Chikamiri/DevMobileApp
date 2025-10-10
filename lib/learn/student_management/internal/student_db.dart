import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class StudentDB {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _init();
    return _db!;
  }

  static Future<Database> _init() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'students.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students(
            id TEXT PRIMARY KEY,
            name TEXT,
            class TEXT
          )
        ''');
      },
    );
  }

  static Future<void> insert(Map<String, String> s) async {
    final db = await database;
    await db.insert(
      'students',
      s,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, String>>> getAll() async {
    final db = await database;
    final List<Map<String, Object?>> result = await db.query(
      'students',
      orderBy: 'id',
    );
    return result
        .map((e) => e.map((k, v) => MapEntry(k, v.toString())))
        .toList();
  }

  static Future<void> delete(String id) async {
    final db = await database;
    await db.delete('students', where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> clear() async {
    final db = await database;
    await db.delete('students');
  }
}
