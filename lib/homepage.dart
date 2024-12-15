import 'package:flutter/material.dart';
import 'package:fitness_app/services/workout_services.dart';
import 'package:fitness_app/models/workout.dart';
import 'chart_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _exerciseController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();
  final TextEditingController _setsController = TextEditingController();

  List<Workout> _savedWorkouts = [];

  @override
  void initState() {
    super.initState();
    _loadWorkouts();
  }

  void _loadWorkouts() {
    setState(() {
      _savedWorkouts = WorkoutService.getWorkouts();
    });
  }

  void _saveWorkout() {
    final exerciseName = _exerciseController.text.trim();
    final reps = int.tryParse(_repsController.text);
    final sets = int.tryParse(_setsController.text);

    if (exerciseName.isEmpty || reps == null || sets == null || reps <= 0 || sets <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter valid inputs!')),
      );
      return;
    }

    final workout = Workout(
      exerciseName: exerciseName,
      reps: reps,
      sets: sets,
      duration: reps * sets,
      date: DateTime.now(),
    );

    WorkoutService.saveWorkout(workout);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Workout Saved!')),
    );

    _exerciseController.clear();
    _repsController.clear();
    _setsController.clear();

    _loadWorkouts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness Tracker', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Exercise input fields
            _buildInputField(_exerciseController, 'Exercise Name (e.g., Running, Yoga)', TextInputType.text),
            SizedBox(height: 16),
            _buildInputField(_repsController, 'Reps', TextInputType.number),
            SizedBox(height: 16),
            _buildInputField(_setsController, 'Sets', TextInputType.number),
            SizedBox(height: 30),

            // Save Workout Button
            ElevatedButton(
              onPressed: _saveWorkout,
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                elevation: 5,
                shadowColor: Colors.deepPurpleAccent,
              ),
              child: Text(
                'Save Workout',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),

            // View Progress Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChartPage(workouts: _savedWorkouts)),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.cyan,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                elevation: 5,
                shadowColor: Colors.cyanAccent,
              ),
              child: Text(
                'View Progress',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),

            // Display saved workouts
            Expanded(
              child: _savedWorkouts.isEmpty
                  ? Center(child: Text('No workouts saved yet!', style: TextStyle(fontSize: 18, color: Colors.black54)))
                  : ListView.builder(
                itemCount: _savedWorkouts.length,
                itemBuilder: (context, index) {
                  final workout = _savedWorkouts[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      title: Text(
                        workout.exerciseName,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${workout.reps} reps x ${workout.sets} sets',
                        style: TextStyle(color: Colors.black54),
                      ),
                      trailing: Text(
                        '${workout.duration} min',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String labelText, TextInputType keyboardType) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.deepPurple),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.deepPurple, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
      ),
    );
  }
}
