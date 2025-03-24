import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:math';

class HealthCalculatorsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Calculators'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          CalculatorCard(
            title: 'BMI Calculator',
            icon: Icons.monitor_weight,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BMICalculator()),
              );
            },
          ),
          CalculatorCard(
            title: 'Calorie Intake Calculator',
            icon: Icons.local_dining,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalorieIntakeCalculator()),
              );
            },
          ),
          CalculatorCard(
            title: 'Water Intake Calculator',
            icon: Icons.local_drink,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WaterIntakeCalculator()),
              );
            },
          ),
          CalculatorCard(
            title: 'Body Fat Calculator',
            icon: Icons.fitness_center,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BodyFatCalculator()),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Calculator Card Widget
class CalculatorCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const CalculatorCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 4,
      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.blue[800]),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue[800],
          ),
        ),
        trailing: Icon(Icons.arrow_forward, color: Colors.blue[800]),
        onTap: onTap,
      ),
    );
  }
}

// BMI Calculator Page
class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double? bmi;
  String? bmiCategory;

  void _calculateBMI() {
    final height = double.tryParse(_heightController.text);
    final weight = double.tryParse(_weightController.text);

    if (height != null && weight != null && height > 0) {
      setState(() {
        bmi = weight / ((height / 100) * (height / 100));
        if (bmi! < 18.5) {
          bmiCategory = 'Underweight';
        } else if (bmi! >= 18.5 && bmi! < 24.9) {
          bmiCategory = 'Normal weight';
        } else if (bmi! >= 25 && bmi! < 29.9) {
          bmiCategory = 'Overweight';
        } else {
          bmiCategory = 'Obese';
        }
      });
    } else {
      setState(() {
        bmi = null;
        bmiCategory = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter valid height and weight.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _heightController,
              decoration: InputDecoration(
                labelText: 'Height (cm)',
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
            ElevatedButton(
              onPressed: _calculateBMI,
              child: Text('Calculate BMI'),
            ),
            SizedBox(height: 16),
            if (bmi != null)
              Column(
                children: [
                  Text(
                    'Your BMI: ${bmi!.toStringAsFixed(1)}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Category: $bmiCategory',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

// Calorie Intake Calculator Page
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

// Water Intake Calculator Page
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

// Body Fat Calculator Page
class BodyFatCalculator extends StatefulWidget {
  @override
  _BodyFatCalculatorState createState() => _BodyFatCalculatorState();
}

class _BodyFatCalculatorState extends State<BodyFatCalculator> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _waistController = TextEditingController();
  final TextEditingController _neckController = TextEditingController();
  String? gender = 'Male';
  double? bodyFatPercentage;

  void _calculateBodyFat() {
    final age = int.tryParse(_ageController.text);
    final weight = double.tryParse(_weightController.text);
    final height = double.tryParse(_heightController.text);
    final waist = double.tryParse(_waistController.text);
    final neck = double.tryParse(_neckController.text);

    if (age != null && weight != null && height != null && waist != null && neck != null &&
        age > 0 && weight > 0 && height > 0 && waist > 0 && neck > 0) {
      double bodyFat;
      if (gender == 'Male') {
        bodyFat = 495 / (1.0324 - 0.19077 * (log(waist - neck)) + 0.15456 * (log(height))) - 450;
      } else {
        bodyFat = 495 / (1.29579 - 0.35004 * (log(waist + neck - height))) - 450;
      }

      setState(() {
        bodyFatPercentage = bodyFat;
      });
    } else {
      setState(() {
        bodyFatPercentage = null;
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
        title: Text('Body Fat Calculator'),
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
            TextField(
              controller: _waistController,
              decoration: InputDecoration(
                labelText: 'Waist Circumference (cm)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _neckController,
              decoration: InputDecoration(
                labelText: 'Neck Circumference (cm)',
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
            ElevatedButton(
              onPressed: _calculateBodyFat,
              child: Text('Calculate Body Fat'),
            ),
            SizedBox(height: 16),
            if (bodyFatPercentage != null)
              Text(
                'Your Body Fat Percentage: ${bodyFatPercentage!.toStringAsFixed(1)}%',
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