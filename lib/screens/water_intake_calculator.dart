import 'package:flutter/material.dart';

class WaterIntakeCalculator extends StatefulWidget {
  @override
  _WaterIntakeCalculatorState createState() => _WaterIntakeCalculatorState();
}

class _WaterIntakeCalculatorState extends State<WaterIntakeCalculator> {
  final TextEditingController _weightController = TextEditingController();
  String? activityLevel = 'Sedentary';
  double? waterIntake;

  void _calculateWaterIntake() {
    final weight = double.tryParse(_weightController.text);

    if (weight != null && weight > 0) {
      double baseIntake = weight * 0.033; // Base intake in liters
      double activityFactor = activityLevel == 'Sedentary'
          ? 1.0
          : activityLevel == 'Lightly Active'
              ? 1.2
              : activityLevel == 'Moderately Active'
                  ? 1.5
                  : activityLevel == 'Very Active'
                      ? 1.8
                      : 2.0;

      setState(() {
        waterIntake = baseIntake * activityFactor;
      });
    } else {
      setState(() {
        waterIntake = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid weight.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Water Intake Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _weightController,
              decoration: InputDecoration(
                labelText: 'Weight (kg)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
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
              onPressed: _calculateWaterIntake,
              child: Text('Calculate Water Intake'),
            ),
            SizedBox(height: 16),
            if (waterIntake != null)
              Text(
                'Your Daily Water Intake: ${waterIntake!.toStringAsFixed(2)} liters',
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