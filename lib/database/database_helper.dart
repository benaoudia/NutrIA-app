import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'nutria_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user_inputs(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        field_name TEXT NOT NULL,
        value TEXT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }

  // Insert a new user input
  Future<int> insertUserInput(String fieldName, String value) async {
    final db = await database;
    return await db.insert('user_inputs', {
      'field_name': fieldName,
      'value': value,
    });
  }

  // Update an existing user input
  Future<int> updateUserInput(String fieldName, String value) async {
    final db = await database;
    return await db.update(
      'user_inputs',
      {
        'value': value,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'field_name = ?',
      whereArgs: [fieldName],
    );
  }

  // Get a specific user input
  Future<Map<String, dynamic>?> getUserInput(String fieldName) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'user_inputs',
      where: 'field_name = ?',
      whereArgs: [fieldName],
    );

    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  // Get all user inputs
  Future<List<Map<String, dynamic>>> getAllUserInputs() async {
    final db = await database;
    return await db.query('user_inputs');
  }

  // Delete a user input
  Future<int> deleteUserInput(String fieldName) async {
    final db = await database;
    return await db.delete(
      'user_inputs',
      where: 'field_name = ?',
      whereArgs: [fieldName],
    );
  }
} 