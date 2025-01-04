// import 'package:flutter/material.dart';
// import '../../models/bmi.dart';

// class BmiPage extends StatefulWidget {
//   const BmiPage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _BmiPageState createState() => _BmiPageState();
// }

// class _BmiPageState extends State<BmiPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _heightController = TextEditingController();
//   final _weightController = TextEditingController();
//   BMI? _bmi;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('BMI Calculator')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _heightController,
//                 decoration: const InputDecoration(labelText: 'Height (cm)'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value!.isEmpty) return 'Please enter your height';
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _weightController,
//                 decoration: const InputDecoration(labelText: 'Weight (kg)'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value!.isEmpty) return 'Please enter your weight';
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     setState(() {
//                       _bmi = BMI(
//                         height: double.parse(_heightController.text),
//                         weight: double.parse(_weightController.text),
//                       );
//                     });
//                   }
//                 },
//                 child: const Text('Calculate BMI'),
//               ),
//               const SizedBox(height: 20),
//               if (_bmi != null)
//                 Column(
//                   children: [
//                     Text(
//                       'Your BMI: ${_bmi!.bmi!.toStringAsFixed(1)}',
//                       style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       'Interpretation: ${_bmi!.interpretation}',
//                       style: const TextStyle(fontSize: 18, color: Colors.blue),
//                     ),
//                   ],
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../../models/bmi.dart';

class BmiPage extends StatefulWidget {
  const BmiPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BmiPageState createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  final _formKey = GlobalKey<FormState>();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  BMI? _bmi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMI Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _heightController,
                decoration: const InputDecoration(labelText: 'Height (cm)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter your height';
                  return null;
                },
              ),
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(labelText: 'Weight (kg)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter your weight';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _bmi = BMI(
                        height: double.parse(_heightController.text),
                        weight: double.parse(_weightController.text),
                      );
                    });
                  }
                },
                child: const Text('Calculate BMI'),
              ),
              const SizedBox(height: 20),
              if (_bmi != null)
                Column(
                  children: [
                    Text(
                      'Your BMI: ${_bmi!.bmi!.toStringAsFixed(1)}',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Interpretation: ${_bmi!.interpretation}',
                      style: const TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}