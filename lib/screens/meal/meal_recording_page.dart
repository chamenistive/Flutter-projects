import 'package:flutter/material.dart';
import '../../models/meal.dart';
import '../../services/meal_service.dart';

class MealRecordingPage extends StatefulWidget {
  const MealRecordingPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MealRecordingPageState createState() => _MealRecordingPageState();
}

class _MealRecordingPageState extends State<MealRecordingPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _caloriesController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Record Meal')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Meal Name'),
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter the meal name';
                  return null;
                },
              ),
              TextFormField(
                controller: _caloriesController,
                decoration: const InputDecoration(labelText: 'Calories'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter the calories';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text('Date: ${_selectedDate.toLocal()}'),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: const Text('Select Date'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final meal = Meal(
                      name: _nameController.text,
                      calories: int.parse(_caloriesController.text),
                      dateTime: _selectedDate,
                    );
                    await MealService.addMeal(meal);
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context); // Return to the previous page
                  }
                },
                child: const Text('Save Meal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}