import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DatabaseHelper {
  static Database? _database;
  static const String _dbName = 'resilio.db';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cache (
        key TEXT PRIMARY KEY,
        value BLOB,
        timestamp INTEGER
      )
    ''');
  }

  Future<void> saveToCache(String key, List<int> value) async {
    final db = await database;
    await db.insert(
      'cache',
      {
        'key': key,
        'value': value,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<int>?> getFromCache(String key) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'cache',
      where: 'key = ?',
      whereArgs: [key],
    );

    if (maps.isNotEmpty) {
      return maps.first['value'] as List<int>;
    }
    return null;
  }

  Future<void> clearCache() async {
    final db = await database;
    await db.delete('cache');
  }
}
