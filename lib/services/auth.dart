// # Authentication service
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user.dart';
import 'database.dart';

class Auth {
  static Future<bool> authenticate(String email, String password) async {
    final db = await DatabaseHelper.initializeDb();
    final users = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return users.isNotEmpty;
  }

  static Future<void> register(String name, String email, String password) async {
    final db = await DatabaseHelper.initializeDb();
    await db.insert(
      'users',
      {'name': name, 'email': email, 'password': password},
    );
  }
}