import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:injectable/injectable.dart';
import 'dart:convert';

@lazySingleton
class DatabaseHelper {
  static Database? _database;
  static const String _dbName = 'resilio.db';
  static const int _dbVersion = 2;

  // Cache duration constants (in minutes)
  static const int cacheValidityDefault = 60;
  static const int cacheValidityShortContent = 30;
  static const int cacheValidityUserData = 120;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Generic cache table for backward compatibility
    await db.execute('''
      CREATE TABLE cache (
        key TEXT PRIMARY KEY,
        value BLOB,
        timestamp INTEGER
      )
    ''');

    // Categories table
    await db.execute('''
      CREATE TABLE categories (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT,
        imageUrl TEXT,
        data TEXT NOT NULL,
        timestamp INTEGER NOT NULL
      )
    ''');

    // Videos table
    await db.execute('''
      CREATE TABLE videos (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        categoryId TEXT,
        duration INTEGER,
        thumbnailUrl TEXT,
        videoUrl TEXT,
        type TEXT,
        isFeatured INTEGER DEFAULT 0,
        data TEXT NOT NULL,
        timestamp INTEGER NOT NULL
      )
    ''');

    // Tips/Content table
    await db.execute('''
      CREATE TABLE tips (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        categoryId TEXT,
        imageUrl TEXT,
        data TEXT NOT NULL,
        timestamp INTEGER NOT NULL
      )
    ''');

    // User preferences table
    await db.execute('''
      CREATE TABLE user_preferences (
        userId TEXT PRIMARY KEY,
        preferences TEXT NOT NULL,
        timestamp INTEGER NOT NULL
      )
    ''');

    // Sync metadata table
    await db.execute('''
      CREATE TABLE sync_metadata (
        entityType TEXT PRIMARY KEY,
        lastSyncTime INTEGER,
        nextSyncTime INTEGER
      )
    ''');

    // Affirmations table
    await db.execute('''
      CREATE TABLE affirmations (
        id TEXT PRIMARY KEY,
        text TEXT NOT NULL,
        categoryId TEXT,
        data TEXT NOT NULL,
        timestamp INTEGER NOT NULL
      )
    ''');

    // Quiz questions table
    await db.execute('''
      CREATE TABLE quiz_questions (
        id TEXT PRIMARY KEY,
        question TEXT NOT NULL,
        categoryId TEXT,
        data TEXT NOT NULL,
        timestamp INTEGER NOT NULL
      )
    ''');

    // Create indexes for better query performance
    await db.execute('CREATE INDEX idx_videos_categoryId ON videos(categoryId)');
    await db.execute('CREATE INDEX idx_tips_categoryId ON tips(categoryId)');
    await db.execute('CREATE INDEX idx_affirmations_categoryId ON affirmations(categoryId)');
    await db.execute('CREATE INDEX idx_quiz_categoryId ON quiz_questions(categoryId)');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Migration from v1 to v2 - add new tables
      await _onCreate(db, newVersion);
    }
  }

  // Generic cache methods (backward compatible)
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

  // Cache validity check
  bool isCacheValid(int timestamp, int validityMinutes) {
    final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final now = DateTime.now();
    return now.difference(cacheTime).inMinutes < validityMinutes;
  }

  // Categories methods
  Future<void> saveCategories(List<Map<String, dynamic>> categories) async {
    final db = await database;
    for (var category in categories) {
      await db.insert(
        'categories',
        {
          'id': category['id'],
          'name': category['name'],
          'description': category['description'],
          'imageUrl': category['imageUrl'],
          'data': jsonEncode(category),
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Map<String, dynamic>>> getCategories() async {
    final db = await database;
    final maps = await db.query('categories');
    return maps.map((map) {
      final data = jsonDecode(map['data'] as String);
      return data as Map<String, dynamic>;
    }).toList();
  }

  Future<void> clearCategories() async {
    final db = await database;
    await db.delete('categories');
  }

  // Videos methods
  Future<void> saveVideos(List<Map<String, dynamic>> videos) async {
    final db = await database;
    for (var video in videos) {
      await db.insert(
        'videos',
        {
          'id': video['id'],
          'title': video['title'],
          'description': video['description'],
          'categoryId': video['categoryId'],
          'duration': video['duration'],
          'thumbnailUrl': video['thumbnailUrl'],
          'videoUrl': video['videoUrl'],
          'type': video['type'],
          'isFeatured': (video['isFeatured'] ?? false) ? 1 : 0,
          'data': jsonEncode(video),
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Map<String, dynamic>>> getVideos({String? categoryId}) async {
    final db = await database;
    List<Map<String, dynamic>> maps;
    
    if (categoryId != null) {
      maps = await db.query(
        'videos',
        where: 'categoryId = ?',
        whereArgs: [categoryId],
      );
    } else {
      maps = await db.query('videos');
    }
    
    return maps.map((map) {
      final data = jsonDecode(map['data'] as String);
      return data as Map<String, dynamic>;
    }).toList();
  }

  Future<void> clearVideos() async {
    final db = await database;
    await db.delete('videos');
  }

  // Tips methods
  Future<void> saveTips(List<Map<String, dynamic>> tips) async {
    final db = await database;
    for (var tip in tips) {
      await db.insert(
        'tips',
        {
          'id': tip['id'],
          'title': tip['title'],
          'content': tip['content'],
          'categoryId': tip['categoryId'],
          'imageUrl': tip['imageUrl'],
          'data': jsonEncode(tip),
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Map<String, dynamic>>> getTips({String? categoryId}) async {
    final db = await database;
    List<Map<String, dynamic>> maps;
    
    if (categoryId != null) {
      maps = await db.query(
        'tips',
        where: 'categoryId = ?',
        whereArgs: [categoryId],
      );
    } else {
      maps = await db.query('tips');
    }
    
    return maps.map((map) {
      final data = jsonDecode(map['data'] as String);
      return data as Map<String, dynamic>;
    }).toList();
  }

  Future<void> clearTips() async {
    final db = await database;
    await db.delete('tips');
  }

  // Affirmations methods
  Future<void> saveAffirmations(List<Map<String, dynamic>> affirmations) async {
    final db = await database;
    for (var affirmation in affirmations) {
      await db.insert(
        'affirmations',
        {
          'id': affirmation['id'],
          'text': affirmation['text'],
          'categoryId': affirmation['categoryId'],
          'data': jsonEncode(affirmation),
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Map<String, dynamic>>> getAffirmations({String? categoryId}) async {
    final db = await database;
    List<Map<String, dynamic>> maps;
    
    if (categoryId != null) {
      maps = await db.query(
        'affirmations',
        where: 'categoryId = ?',
        whereArgs: [categoryId],
      );
    } else {
      maps = await db.query('affirmations');
    }
    
    return maps.map((map) {
      final data = jsonDecode(map['data'] as String);
      return data as Map<String, dynamic>;
    }).toList();
  }

  Future<void> clearAffirmations() async {
    final db = await database;
    await db.delete('affirmations');
  }

  // Quiz questions methods
  Future<void> saveQuizQuestions(List<Map<String, dynamic>> questions) async {
    final db = await database;
    for (var question in questions) {
      await db.insert(
        'quiz_questions',
        {
          'id': question['id'],
          'question': question['question'],
          'categoryId': question['categoryId'],
          'data': jsonEncode(question),
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Map<String, dynamic>>> getQuizQuestions({String? categoryId}) async {
    final db = await database;
    List<Map<String, dynamic>> maps;
    
    if (categoryId != null) {
      maps = await db.query(
        'quiz_questions',
        where: 'categoryId = ?',
        whereArgs: [categoryId],
      );
    } else {
      maps = await db.query('quiz_questions');
    }
    
    return maps.map((map) {
      final data = jsonDecode(map['data'] as String);
      return data as Map<String, dynamic>;
    }).toList();
  }

  Future<void> clearQuizQuestions() async {
    final db = await database;
    await db.delete('quiz_questions');
  }

  // Preferences methods
  Future<void> saveUserPreferences(String userId, Map<String, dynamic> preferences) async {
    final db = await database;
    await db.insert(
      'user_preferences',
      {
        'userId': userId,
        'preferences': jsonEncode(preferences),
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getUserPreferences(String userId) async {
    final db = await database;
    final maps = await db.query(
      'user_preferences',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    
    if (maps.isNotEmpty) {
      return jsonDecode(maps.first['preferences'] as String);
    }
    return null;
  }

  // Sync metadata methods
  Future<void> updateSyncMetadata(String entityType, int nextSyncMinutes) async {
    final db = await database;
    final now = DateTime.now().millisecondsSinceEpoch;
    final nextSync = now + (nextSyncMinutes * 60 * 1000);
    
    await db.insert(
      'sync_metadata',
      {
        'entityType': entityType,
        'lastSyncTime': now,
        'nextSyncTime': nextSync,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> shouldSync(String entityType) async {
    final db = await database;
    final maps = await db.query(
      'sync_metadata',
      where: 'entityType = ?',
      whereArgs: [entityType],
    );
    
    if (maps.isEmpty) return true;
    
    final nextSyncTime = maps.first['nextSyncTime'] as int?;
    if (nextSyncTime == null) return true;
    
    return DateTime.now().millisecondsSinceEpoch > nextSyncTime;
  }
}
