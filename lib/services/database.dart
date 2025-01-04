// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DatabaseHelper {
//   static Future<Database> initializeDb() async {
//     final dbPath = await getDatabasesPath();
//     return openDatabase(
//       join(dbPath, 'meal_planner.db'),
//       onCreate: (db, version) async {
//         await db.execute(
//           'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, email TEXT, password TEXT)',
//         );
//         await db.execute(
//           'CREATE TABLE meals(id INTEGER PRIMARY KEY, name TEXT, calories INTEGER, dateTime TEXT)',
//         );
//       },
//       version: 1,
//     );
//   }

//   static Future<void> deleteDatabase(String path) async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, 'meal_planner.db');
//     await deleteDatabase(path);
//   }
// }
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';
import 'dart:developer' as developer;

class DatabaseHelper {
  static sql.Database? _database;

  static Future<sql.Database> get database async {
    if (_database != null) return _database!;
    _database = await initializeDb();
    return _database!;
  }

  static Future<sql.Database> initializeDb() async {
    final dbPath = await sql.getDatabasesPath();
    final path = join(dbPath, 'meal_planner.db');

    developer.log('Initializing database at: $path');

    return sql.openDatabase(
      path,
      onCreate: (db, version) async {
        developer.log('Creating tables...');
        await db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, email TEXT, password TEXT)',
        );
        await db.execute(
          'CREATE TABLE meals(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, calories INTEGER NOT NULL, dateTime TEXT NOT NULL)',
        );
        developer.log('Tables created successfully.');
      },
      version: 1,
      onOpen: (db) {
        developer.log('Database opened successfully.');
      },
    );
  }

  static Future<void> deleteDb() async {
    final dbPath = await sql.getDatabasesPath();
    final path = join(dbPath, 'meal_planner.db');
    developer.log('Deleting database at: $path');
    await sql.deleteDatabase(path);
  }
   static Future<void> checkTablesExist() async {
   try {
     final db = await DatabaseHelper.database;
     final tables = await db.rawQuery(
       "SELECT name FROM sqlite_master WHERE type='table';"
     );
     developer.log('Existing tables: $tables');
   } catch (e) {
     developer.log('Error checking tables: $e');
     throw Exception('Failed to check tables: $e');
   }
 }
static Future<void> logExistingTables() async {
  final db = await DatabaseHelper.database;
  final tables = await db.rawQuery(
    "SELECT name FROM sqlite_master WHERE type='table';"
  );
  developer.log('Existing tables: $tables');
}

}