import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Future<Database> initializeDb() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'meal_planner.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, email TEXT, password TEXT)',
        ).then((_) {
          return db.execute(
            'CREATE TABLE meals(id INTEGER PRIMARY KEY, name TEXT, calories INTEGER, dateTime TEXT)',
          );
        });
      },
      version: 1,
    );
  }
}