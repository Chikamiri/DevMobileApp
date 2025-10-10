import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../database/user_model.dart';

class DatabaseManager {
  static const _databaseName = "./UserDatabase.db";
  static const _databaseVersion = 1;

  static const table = 'users';

  static const columnId = 'id';
  static const columnFullName = 'fullName';
  static const columnEmail = 'email';
  static const columnPassword = 'password';

  DatabaseManager._privateConstructor();
  static final DatabaseManager instance = DatabaseManager._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnFullName TEXT NOT NULL,
            $columnEmail TEXT NOT NULL UNIQUE,
            $columnPassword TEXT NOT NULL
          )
          ''');
  }

  Future<int> signUp(User user) async {
    Database db = await instance.database;
    return await db.insert(table, user.toMap());
  }

  Future<User?> logIn(String email, String password) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(
      table,
      where: '$columnEmail = ? AND $columnPassword = ?',
      whereArgs: [email, password],
    );
    if (maps.isNotEmpty) {
      return User(
        id: maps[0][columnId],
        fullName: maps[0][columnFullName],
        email: maps[0][columnEmail],
        password: maps[0][columnPassword],
      );
    }
    return null;
  }
}
