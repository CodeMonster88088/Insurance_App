import 'package:flutter/material.dart';

class CalorieIntakeCalculator extends StatefulWidget {
  @override
  _CalorieIntakeCalculatorState createState() => _CalorieIntakeCalculatorState();
}

class _CalorieIntakeCalculatorState extends State<CalorieIntakeCalculator> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  String? gender = 'Male';
  String? activityLevel = 'Sedentary';
  double? calorieIntake;

  void _calculateCalorieIntake() {
    final age = int.tryParse(_ageController.text);
    final weight = double.tryParse(_weightController.text);
    final height = double.tryParse(_heightController.text);

    if (age != null && weight != null && height != null && age > 0 && weight > 0 && height > 0) {
      double bmr = gender == 'Male'
          ? 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age)
          : 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);

      double activityFactor = activityLevel == 'Sedentary'
          ? 1.2
          : activityLevel == 'Lightly Active'
              ? 1.375
              : activityLevel == 'Moderately Active'
                  ? 1.55
                  : activityLevel == 'Very Active'
                      ? 1.725
                      : 1.9;

      setState(() {
        calorieIntake = bmr * activityFactor;
      });
    } else {
      setState(() {
        calorieIntake = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter valid inputs.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calorie Intake Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _ageController,
              decoration: InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _weightController,
              decoration: InputDecoration(
                labelText: 'Weight (kg)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _heightController,
              decoration: InputDecoration(
                labelText: 'Height (cm)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: gender,
              items: ['Male', 'Female'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  gender = newValue;
                });
              },
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: activityLevel,
              items: ['Sedentary', 'Lightly Active', 'Moderately Active', 'Very Active', 'Extra Active']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  activityLevel = newValue;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculateCalorieIntake,
              child: Text('Calculate Calorie Intake'),
            ),
            SizedBox(height: 16),
            if (calorieIntake != null)
              Text(
                'Your Daily Calorie Intake: ${calorieIntake!.toStringAsFixed(0)} kcal',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
          ],
        ),
      ),
    );
  }
}