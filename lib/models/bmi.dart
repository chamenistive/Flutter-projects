//BMI model
class BMI {
  final double height; // in cm
  final double weight; // in kg
  double? bmi;
  String? interpretation;

  BMI({required this.height, required this.weight}) {
    bmi = calculateBMI();
    interpretation = interpretBMI();
  }

  double calculateBMI() {
    double heightInMeters = height / 100;
    return weight / (heightInMeters * heightInMeters);
  }

  String interpretBMI() {
    if (bmi! < 18.5) {
      return 'Underweight';
    } else if (bmi! >= 18.5 && bmi! < 24.9) {
      return 'Normal weight';
    } else if (bmi! >= 25 && bmi! < 29.9) {
      return 'Overweight';
    } else {
      return 'Obesity';
    }
  }
}