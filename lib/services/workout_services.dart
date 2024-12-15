// lib/services/workout_service.dart
import 'package:fitness_app/models/workout.dart';

class WorkoutService {
  static final List<Workout> _workouts = [];  // In-memory list

  // Method to get all workouts
  static List<Workout> getWorkouts() {
    return _workouts;
  }

  // Method to save a new workout
  static void saveWorkout(Workout workout) {
    _workouts.add(workout);  // Save the workout to the list
  }
}
