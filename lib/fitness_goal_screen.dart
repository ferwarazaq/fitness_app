// lib/pages/fitness_goal_page.dart
import 'package:flutter/material.dart';

class FitnessGoalPage extends StatefulWidget {
  @override
  _FitnessGoalPageState createState() => _FitnessGoalPageState();
}

class _FitnessGoalPageState extends State<FitnessGoalPage> {
  final _goalController = TextEditingController();
  String _goalMessage = '';

  void _setGoal() {
    setState(() {
      _goalMessage = 'Goal Set: ${_goalController.text}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Set Fitness Goal')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _goalController,
              decoration: InputDecoration(labelText: 'Your Fitness Goal'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _setGoal,
              child: Text('Set Goal'),
            ),
            if (_goalMessage.isNotEmpty) Text(_goalMessage),
          ],
        ),
      ),
    );
  }
}
