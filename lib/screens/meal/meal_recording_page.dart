import 'package:flutter/material.dart';

class MealRecordingPage extends StatelessWidget {
  const MealRecordingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Record Meal')),
      body: const Center(
        child: Text('Meal Recording Page'),
      ),
    );
  }
}