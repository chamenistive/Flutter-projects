// // # Meal-related operations
// import 'package:sqflite/sqflite.dart';
// import '../models/meal.dart';
// import 'database.dart';

// class MealService {
//   static Future<void> addMeal(Meal meal) async {
//     final db = await DatabaseHelper.initializeDb();
//     await db.insert('meals', meal.toMap());
//   }

//   static Future<List<Meal>> getMeals() async {
//     final db = await DatabaseHelper.initializeDb();
//     final List<Map<String, dynamic>> maps = await db.query('meals');
//     return List.generate(maps.length, (i) {
//       return Meal.fromMap(maps[i]);
//     });
//   }

//   static Future<void> updateMeal(Meal meal) async {
//     final db = await DatabaseHelper.initializeDb();
//     await db.update(
//       'meals',
//       meal.toMap(),
//       where: 'id = ?',
//       whereArgs: [meal.id],
//     );
//   }

//   static Future<void> deleteMeal(int id) async {
//     final db = await DatabaseHelper.initializeDb();
//     await db.delete(
//       'meals',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }
// }import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';
import '../models/meal.dart';
import '../services/database.dart';
import 'dart:developer' as developer;

class MealService {
  static Future<void> addMeal(Meal meal) async {
  if (meal.dateTime == null || meal.dateTime.toString().isEmpty) {
  throw Exception('Invalid meal data.');
}

  try {
    final db = await DatabaseHelper.database;
    await db.insert(
      'meals',
      meal.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    developer.log('Meal added successfully: ${meal.toMap()}');
  } catch (e) {
    developer.log('Error adding meal: $e');
    throw Exception('Failed to add meal: $e');
  }
}


  static Future<List<Meal>> getMeals() async {
    try {
      final db = await DatabaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query('meals');
      developer.log('Retrieved ${maps.length} meals from database');
      return List.generate(maps.length, (i) {
        return Meal.fromMap(maps[i]);
      });
    } catch (e) {
      developer.log('Error getting meals: $e');
      throw Exception('Failed to get meals: $e');
    }
  }

  static Future<void> updateMeal(Meal meal) async {
  if (meal.id == null) {
    throw Exception('Meal ID cannot be null.');
  }
  try {
    final db = await DatabaseHelper.database;
    final rowsAffected = await db.update(
      'meals',
      meal.toMap(),
      where: 'id = ?',
      whereArgs: [meal.id],
    );
    if (rowsAffected == 0) {
      throw Exception('No meal found with id ${meal.id}');
    }
    developer.log('Updated meal with id ${meal.id}. Rows affected: $rowsAffected');
  } catch (e) {
    developer.log('Error updating meal: $e');
    throw Exception('Failed to update meal: $e');
  }
}

  static Future<void> deleteMeal(int id) async {
  if (id <= 0) {
    throw Exception('Invalid meal ID.');
  }
  try {
    final db = await DatabaseHelper.database;
    final rowsAffected = await db.delete(
      'meals',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (rowsAffected == 0) {
      throw Exception('No meal found with id $id');
    }
    developer.log('Deleted meal with id $id. Rows affected: $rowsAffected');
  } catch (e) {
    developer.log('Error deleting meal: $e');
    throw Exception('Failed to delete meal: $e');
  }
}
static Future<List<Meal>> getMealsByCalories(int minCalories, int maxCalories) async {
  final db = await DatabaseHelper.initializeDb();
  final List<Map<String, dynamic>> maps = await db.query(
    'meals',
    where: 'calories >= ? AND calories <= ?',
    whereArgs: [minCalories, maxCalories],
  );
  return List.generate(maps.length, (i) {
    return Meal.fromMap(maps[i]);
  });
}
  
}