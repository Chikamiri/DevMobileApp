import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('warehouse.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        quantity INTEGER,
        price REAL,
        supplierId INTEGER
      )
    ''');

    await db.execute('''
    CREATE TABLE suppliers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        code TEXT,
        name TEXT,
        address TEXT,
        phone TEXT
    )
    ''');

    await db.execute('''
        CREATE TABLE customers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    code TEXT,
    name TEXT,
    address TEXT,
    phone TEXT
  )
''');

    await db.execute('''
      CREATE TABLE exports (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        productId INTEGER,
        customerId INTEGER,
        quantity INTEGER,
        date TEXT
      )
    ''');

    await db.execute('''
    CREATE TABLE imports (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        productId INTEGER,
        supplierId INTEGER,
        quantity INTEGER,
        date TEXT
    )
    ''');
  }

  // ================= PRODUCTS =================
  Future<int> insertProduct(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('products', data);
  }

  Future<List<Map<String, dynamic>>> getProducts() async {
    final db = await database;
    return await db.query('products');
  }

  Future<int> updateProduct(int id, Map<String, dynamic> data) async {
    final db = await database;
    return await db.update('products', data, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteProduct(int id) async {
    final db = await database;
    return await db.delete('products', where: 'id = ?', whereArgs: [id]);
  }

  // ================= SUPPLIERS =================
  Future<int> insertSupplier(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('suppliers', data);
  }

  Future<List<Map<String, dynamic>>> getSuppliers() async {
    final db = await database;
    return await db.query('suppliers');
  }

  Future<int> updateSupplier(int id, Map<String, dynamic> data) async {
    final db = await database;
    return await db.update('suppliers', data, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteSupplier(int id) async {
    final db = await database;
    return await db.delete('suppliers', where: 'id = ?', whereArgs: [id]);
  }

  // ================= CUSTOMERS =================
  Future<int> insertCustomer(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('customers', data);
  }

  Future<List<Map<String, dynamic>>> getCustomers() async {
    final db = await database;
    return await db.query('customers');
  }

  Future<int> deleteCustomer(int id) async {
    final db = await database;
    return await db.delete('customers', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateCustomer(int id, Map<String, dynamic> data) async {
    final db = await database;
    return await db.update('customers', data, where: 'id = ?', whereArgs: [id]);
  }

  // ================= IMPORTS =================
  Future<int> insertImport(Map<String, dynamic> data) async {
    final db = await database;
    final productId = data['productId'];
    final qty = data['quantity'] as int;

    final product = await db.query(
      'products',
      where: 'id = ?',
      whereArgs: [productId],
    );

    if (product.isNotEmpty) {
      final currentQty = product.first['quantity'] as int;
      final newQty = currentQty + qty;
      await db.update(
        'products',
        {'quantity': newQty},
        where: 'id = ?',
        whereArgs: [productId],
      );
    }

    return await db.insert('imports', data);
  }

  Future<List<Map<String, dynamic>>> getImports() async {
    final db = await database;
    return await db.query('imports', orderBy: 'date DESC');
  }

  // ================= EXPORTS =================
  Future<int> insertExport(Map<String, dynamic> data) async {
    final db = await database;
    final productId = data['productId'];
    final qty = data['quantity'] as int;

    final product = await db.query(
      'products',
      where: 'id = ?',
      whereArgs: [productId],
    );

    if (product.isNotEmpty) {
      final currentQty = product.first['quantity'] as int;
      final newQty = currentQty - qty;
      await db.update(
        'products',
        {'quantity': newQty < 0 ? 0 : newQty},
        where: 'id = ?',
        whereArgs: [productId],
      );
    }

    return await db.insert('exports', data);
  }

  Future<List<Map<String, dynamic>>> getExports() async {
    final db = await database;
    return await db.query('exports');
  }

  // ================= TOOLS =================
  Future<void> resetDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
    await database;
  }

  Future<void> deleteAndResetDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'warehouse.db');

    if (_database != null) {
      await _database!.close();
      _database = null;
    }
    await deleteDatabase(path);
    await _initDB('warehouse.db');
  }
}
