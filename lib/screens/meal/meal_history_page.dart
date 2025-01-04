import 'package:flutter/material.dart';
import '../../models/meal.dart';
import '../../services/meal_service.dart';

class MealHistoryPage extends StatefulWidget {
  const MealHistoryPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MealHistoryPageState createState() => _MealHistoryPageState();
}

class _MealHistoryPageState extends State<MealHistoryPage> {
  late Future<List<Meal>> _mealsFuture;

  @override
  void initState() {
    super.initState();
    _mealsFuture = MealService.getMeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meal History')),
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
            return ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                return ListTile(
                  title: Text(meal.name),
                  subtitle: Text('${meal.calories} kcal on ${meal.dateTime.toLocal()}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await MealService.deleteMeal(meal.id!);
                      setState(() {
                        _mealsFuture = MealService.getMeals();
                      });
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}