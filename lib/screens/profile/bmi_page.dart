import 'package:flutter/material.dart';

class BmiPage extends StatelessWidget {
  const BmiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMI Details')),
      body: const Center(
        child: Text('BMI Details Page'),
      ),
    );
  }
}