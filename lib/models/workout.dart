class Workout {
  final String exerciseName;
  final int reps;
  final int sets;
  final int duration; // Duration could be reps * sets (as an example)
  final DateTime date; // Track when the workout was done

  Workout({
    required this.exerciseName,
    required this.reps,
    required this.sets,
    required this.duration,
    required this.date,
  });
}
