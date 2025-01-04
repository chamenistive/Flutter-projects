// import 'package:flutter/material.dart';
// import 'package:meal_habbit_app/models/meal.dart';
// import '../../services/meal_recommendation_service.dart';
// import '../../models/meal_recommendation.dart';

// class RecommendationsPage extends StatelessWidget {
//   final String bmiCategory;

//   const RecommendationsPage({super.key, required this.bmiCategory});

//   @override
//   Widget build(BuildContext context) {
//     final recommendations = MealRecommendationService.getRecommendations(bmiCategory);

//     return Scaffold(
//       appBar: AppBar(title: const Text('Meal Recommendations')),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: recommendations.length,
//         itemBuilder: (context, index) {
//           final meal = recommendations[index];
//           return Card(
//             margin: const EdgeInsets.only(bottom: 16),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     meal.name,
//                     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 8),
//                   Text('Calories: ${meal.calories} kcal'),
//                   const SizedBox(height: 8),
//                   Text(meal.description),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// extension on Future<List<Meal>> {
//   get length => null;
// }

import 'package:flutter/material.dart';
import '../../services/meal_recommendation_service.dart';
import '../../models/meal.dart';

class RecommendationsPage extends StatefulWidget {
  final String bmiCategory;

  const RecommendationsPage({super.key, required this.bmiCategory});

  @override
  // ignore: library_private_types_in_public_api
  _RecommendationsPageState createState() => _RecommendationsPageState();
}

class _RecommendationsPageState extends State<RecommendationsPage> {
  late Future<List<Meal>> _recommendedMealsFuture;

  @override
  void initState() {
    super.initState();
    _recommendedMealsFuture = MealRecommendationService.getRecommendations(widget.bmiCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meal Recommendations')),
      body: FutureBuilder<List<Meal>>(
        future: _recommendedMealsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No recommended meals found.'));
          } else {
            final meals = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          meal.name,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text('Calories: ${meal.calories} kcal'),
                        const SizedBox(height: 8),
                        Text('Date: ${meal.dateTime.toLocal()}'),
                      ],
                    ),
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