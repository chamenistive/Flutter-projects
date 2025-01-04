// import 'package:flutter/material.dart';
// import 'package:meal_habbit_app/screens/meal/meal_history_page.dart';
// import 'package:meal_habbit_app/services/database.dart';
// import 'screens/auth/splash_screen.dart';
// import 'screens/auth/login_page.dart';
// import 'screens/auth/registration_page.dart';
// import 'screens/home/home_page.dart';
// import 'screens/profile/bmi_page.dart';
// import 'screens/meal/meal_recording_page.dart';
// import 'screens/statistics/statistics_page.dart';
// import 'screens/recommendations/recommendations_page.dart';
// // import 'package:meal_habbit_app/services/database.dart';

// void main() async {
//      WidgetsFlutterBinding.ensureInitialized();
//   // await DatabaseHelper.deleteDatabase(); // Delete the existing database
//   runApp(const MealPlannerApp());
// }

// class MealPlannerApp extends StatelessWidget {
//   const MealPlannerApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       routes: {
//         '/': (context) => const SplashScreen(),
//         '/login': (context) => LoginPage(),
//         '/register': (context) => RegistrationPage(),
//         '/home': (context) => const HomePage(),
//         '/bmi': (context) => const BmiPage(),
//         '/mealRecording': (context) => const MealRecordingPage(),
//         '/statistics': (context) => const StatisticsPage(),
//         '/recommendations': (context) => const RecommendationsPage(),
//          '/mealHistory': (context) => const MealHistoryPage(),
//       },
//       initialRoute: '/',
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:meal_habbit_app/screens/meal/meal_history_page.dart';
import 'package:meal_habbit_app/services/database.dart';
import 'package:meal_habbit_app/services/meal_service.dart';
import 'screens/auth/splash_screen.dart';
import 'screens/auth/login_page.dart';
import 'screens/auth/registration_page.dart';
import 'screens/home/home_page.dart';
import 'screens/profile/bmi_page.dart';
import 'screens/meal/meal_recording_page.dart';
import 'screens/statistics/statistics_page.dart';
import 'screens/recommendations/recommendations_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await DatabaseHelper.deleteDb();
    await DatabaseHelper.initializeDb();
    final db = await DatabaseHelper.database;
    await DatabaseHelper.checkTablesExist();

  // Uncomment the following line only during development
  // await DatabaseHelper.deleteDatabase(); // Delete the existing database
  runApp(const MealPlannerApp());
}

class MealPlannerApp extends StatelessWidget {
  const MealPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => LoginPage(), // Remove const
        '/register': (context) => RegistrationPage(), // Remove const
        '/home': (context) => const HomePage(),
        '/bmi': (context) => const BmiPage(),
        '/mealRecording': (context) => const MealRecordingPage(),
        '/statistics': (context) => const StatisticsPage(),
        '/recommendations': (context) => const RecommendationsPage(),
        '/mealHistory': (context) => const MealHistoryPage(),
      },
      initialRoute: '/',
    );
  }
}