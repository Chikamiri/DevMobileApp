import 'package:flutter/foundation.dart';
import 'db_helper.dart';

class DataProvider extends ChangeNotifier {
  final DatabaseHelper db = DatabaseHelper();

  Future<void> refreshAll() async {
    notifyListeners();
  }

  Future<void> addSupplier(Map<String, dynamic> supplier) async {
    await db.insertSupplier(supplier);
    notifyListeners();
  }

  Future<void> addProduct(Map<String, dynamic> product) async {
    await db.insertProduct(product);
    notifyListeners();
  }

  Future<void> addExport(Map<String, dynamic> export) async {
    await db.insertExport(export);
    notifyListeners();
  }
}
