import 'package:flutter/material.dart';
import '../profile/bmi_page.dart';
import '../meal/meal_recording_page.dart';
import '../statistics/statistics_page.dart';
import '../recommendations/recommendations_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Planner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Logout logic (clear session and navigate to login)
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // BMI Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Your BMI',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '22.5', // Replace with dynamic BMI value
                      style: TextStyle(fontSize: 24, color: Colors.blue),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/bmi');
                      },
                      child: const Text('View Details'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Quick Actions
            const Text(
              'Quick Actions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  context,
                  icon: Icons.restaurant,
                  label: 'Record Meal',
                  route: '/mealRecording',
                ),
                _buildActionButton(
                  context,
                  icon: Icons.bar_chart,
                  label: 'Statistics',
                  route: '/statistics',
                ),
                _buildActionButton(
                  context,
                  icon: Icons.recommend,
                  label: 'Recommendations',
                  route: '/recommendations',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, {required IconData icon, required String label, required String route}) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, size: 40),
          onPressed: () {
            Navigator.pushNamed(context, route);
          },
        ),
        Text(label),
      ],
    );
  }
}