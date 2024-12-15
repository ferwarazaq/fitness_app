import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/models/workout.dart';

class ChartPage extends StatelessWidget {
  final List<Workout> workouts;

  ChartPage({required this.workouts});

  @override
  Widget build(BuildContext context) {
    // Filter workouts from the last 7 days
    final sevenDaysAgo = DateTime.now().subtract(Duration(days: 7));
    final filteredWorkouts = workouts.where((workout) {
      return workout.date.isAfter(sevenDaysAgo);
    }).toList();

    // Group data by exercise name and sum reps
    final Map<String, int> exerciseReps = {};
    for (var workout in filteredWorkouts) {
      if (exerciseReps.containsKey(workout.exerciseName)) {
        exerciseReps[workout.exerciseName] = exerciseReps[workout.exerciseName]! + workout.reps;
      } else {
        exerciseReps[workout.exerciseName] = workout.reps;
      }
    }

    // Debugging: Print the grouped data
    print(exerciseReps);

    // Create data for the chart
    final exerciseNames = exerciseReps.keys.toList();
    final repsData = exerciseReps.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Progress'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Chart title
            Text(
              'Workout Progress',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple[800],
              ),
            ),
            SizedBox(height: 20),
            // Progress Chart
            Expanded(
              child: BarChart(
                BarChartData(
                  barGroups: repsData.asMap().entries.map((entry) {
                    int index = entry.key;
                    int reps = entry.value;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          y: reps.toDouble(),
                          colors: [Colors.blueAccent, Colors.lightBlue], // Gradient effect
                          width: 22,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ],
                      showingTooltipIndicators: [0],
                    );
                  }).toList(),
                  titlesData: FlTitlesData(
                    leftTitles: SideTitles(
                      showTitles: true,
                      getTitles: (value) {
                        if (value % 1 == 0) {
                          return value.toInt().toString(); // Show only whole numbers
                        }
                        return '';
                      },
                      margin: 12,
                      getTextStyles: (context, value) => TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTitles: (double value) {
                        int index = value.toInt();
                        if (index >= 0 && index < exerciseNames.length) {
                          return exerciseNames[index];
                        }
                        return '';
                      },
                      margin: 10,
                      getTextStyles: (context, value) => TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      rotateAngle: 45, // Rotate titles to avoid overlap
                    ),
                  ),
                  gridData: FlGridData(
                    show: false, // Disable grid for better visibility
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: Colors.black.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  minY: 0, // Set minimum Y value to 0
                ),
              ),
            ),
            SizedBox(height: 20),
            // Subtitle
            Text(
              'Number of Reps per Exercise',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.deepPurple[700],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
