// import '../models/meal_recommendation.dart';

// class MealRecommendationService {
//   static List<MealRecommendation> getRecommendations(String bmiCategory) {
//     switch (bmiCategory) {
//       case 'Underweight':
//         return [
//           MealRecommendation(
//             name: 'Avocado Toast with Eggs',
//             calories: 400,
//             description: 'High-calorie breakfast to boost energy.',
//           ),
//           MealRecommendation(
//             name: 'Peanut Butter Banana Smoothie',
//             calories: 500,
//             description: 'Rich in calories and nutrients.',
//           ),
//         ];
//       case 'Normal weight':
//         return [
//           MealRecommendation(
//             name: 'Grilled Chicken Salad',
//             calories: 350,
//             description: 'Balanced meal with lean protein and veggies.',
//           ),
//           MealRecommendation(
//             name: 'Quinoa Bowl with Veggies',
//             calories: 400,
//             description: 'Nutrient-dense and filling.',
//           ),
//         ];
//       case 'Overweight':
//       case 'Obesity':
//         return [
//           MealRecommendation(
//             name: 'Vegetable Stir-Fry',
//             calories: 300,
//             description: 'Low-calorie and packed with nutrients.',
//           ),
//           MealRecommendation(
//             name: 'Grilled Fish with Steamed Broccoli',
//             calories: 350,
//             description: 'Light and healthy meal.',
//           ),
//         ];
//       default:
//         return [];
//     }
//   }
// }
import '../models/meal.dart';
import 'meal_service.dart';

class MealRecommendationService {
  static Future<List<Meal>> getRecommendations(String bmiCategory) async {
    switch (bmiCategory) {
      case 'Underweight':
        return await MealService.getMealsByCalories(500, 10000); // High-calorie meals
      case 'Normal weight':
        return await MealService.getMealsByCalories(300, 500); // Medium-calorie meals
      case 'Overweight':
      case 'Obesity':
        return await MealService.getMealsByCalories(0, 300); // Low-calorie meals
      default:
        return [];
    }
  }
}