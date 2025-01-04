import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../services/meal_service.dart';
import '../../models/meal.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  late Future<List<Meal>> _mealsFuture;

  @override
  void initState() {
    super.initState();
    _mealsFuture = MealService.getMeals();
  }

  // Calculate total calories for a specific day
  int _calculateDailyCalories(List<Meal> meals, DateTime date) {
    return meals
        .where((meal) =>
            meal.dateTime.year == date.year &&
            meal.dateTime.month == date.month &&
            meal.dateTime.day == date.day)
        .fold(0, (sum, meal) => sum + meal.calories);
  }

  // Calculate total calories for a specific week
  int _calculateWeeklyCalories(List<Meal> meals, DateTime startOfWeek) {
    return meals
        .where((meal) =>
            meal.dateTime.isAfter(startOfWeek) &&
            meal.dateTime.isBefore(startOfWeek.add(const Duration(days: 7))))
        .fold(0, (sum, meal) => sum + meal.calories);
  }

  // Calculate total calories for a specific month
  int _calculateMonthlyCalories(List<Meal> meals, DateTime date) {
    return meals
        .where((meal) =>
            meal.dateTime.year == date.year &&
            meal.dateTime.month == date.month)
        .fold(0, (sum, meal) => sum + meal.calories);
  }

  // Calculate total calories for a specific year
  int _calculateYearlyCalories(List<Meal> meals, DateTime date) {
    return meals
        .where((meal) => meal.dateTime.year == date.year)
        .fold(0, (sum, meal) => sum + meal.calories);
  }

  // Calculate average weekly calories
  double _calculateAverageWeeklyCalories(List<Meal> meals) {
    if (meals.isEmpty) return 0;
    final firstMealDate = meals.first.dateTime;
    final lastMealDate = meals.last.dateTime;
    final weeks = lastMealDate.difference(firstMealDate).inDays / 7;
    return weeks > 0 ? _calculateYearlyCalories(meals, DateTime.now()) / weeks : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: FutureBuilder<List<Meal>>(
        future: _mealsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No meals recorded yet.'));
          } else {
            final meals = snapshot.data!;
            final now = DateTime.now();
            final dailyCalories = _calculateDailyCalories(meals, now);
            final weeklyCalories = _calculateWeeklyCalories(meals, now.subtract(Duration(days: now.weekday - 1)));
            final monthlyCalories = _calculateMonthlyCalories(meals, now);
            final yearlyCalories = _calculateYearlyCalories(meals, now);
            final averageWeeklyCalories = _calculateAverageWeeklyCalories(meals);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Calorie Statistics',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  _buildStatCard('Today', '$dailyCalories kcal'),
                  _buildStatCard('This Week', '$weeklyCalories kcal'),
                  _buildStatCard('This Month', '$monthlyCalories kcal'),
                  _buildStatCard('This Year', '$yearlyCalories kcal'),
                  _buildStatCard('Average Weekly', '${averageWeeklyCalories.toStringAsFixed(1)} kcal'),
                  const SizedBox(height: 20),
                  const Text(
                    'Weekly Calorie Trends',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    child: BarChart(
                      BarChartData(
                        barGroups: _buildWeeklyBarGroups(meals),
                        borderData: FlBorderData(show: false),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) {
                            return Text(value.toString());
                          }),
                        ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  List<BarChartGroupData> _buildWeeklyBarGroups(List<Meal> meals) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final barGroups = <BarChartGroupData>[];

    for (int i = 0; i < 7; i++) {
      final day = startOfWeek.add(Duration(days: i));
      final calories = _calculateDailyCalories(meals, day);
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
          BarChartRodData(toY: 8, color: Colors.blue)
          ],
        ),
      );
    }

    return barGroups;
  }
}
