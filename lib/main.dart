import 'package:flutter/material.dart';
import 'screens/auth/splash_screen.dart';
import 'screens/auth/login_page.dart';
import 'screens/auth/registration_page.dart';
import 'screens/home/home_page.dart';
import 'screens/profile/bmi_page.dart';
import 'screens/meal/meal_recording_page.dart';
import 'screens/statistics/statistics_page.dart';
import 'screens/recommendations/recommendations_page.dart';

void main() {
  runApp(const MealPlannerApp());
}

class MealPlannerApp extends StatelessWidget {
  const MealPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegistrationPage(),
        '/home': (context) => const HomePage(),
        '/bmi': (context) => const BmiPage(),
        '/mealRecording': (context) => const MealRecordingPage(),
        '/statistics': (context) => const StatisticsPage(),
        '/recommendations': (context) => const RecommendationsPage(),
      },
      initialRoute: '/',
    );
  }
}