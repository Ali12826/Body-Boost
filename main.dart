import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Exercise {
  final String name;
  final String imageUrl;

  Exercise({required this.name, required this.imageUrl});
}

class MyApp extends StatelessWidget {
  final List<Exercise> exercises = [
    Exercise(name: 'Push-ups', imageUrl: 'assets/pushups.png'),
    Exercise(name: 'Squats', imageUrl: 'assets/squats.png'),
    Exercise(name: 'Plank', imageUrl: 'assets/plank.png'),
    // Add more exercises as needed
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercise Page',
      home: ExercisePage(exercises: exercises),
    );
  }
}

class ExercisePage extends StatelessWidget {
  final List<Exercise> exercises;

  ExercisePage({required this.exercises});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Page'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey, // Set your desired background color here
        ),
        child: ListView.builder(
          itemCount: exercises.length,
          itemBuilder: (context, index) {
            return ExerciseCard(exercise: exercises[index]);
          },
        ),
      ),
    );
  }
}

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;

  ExerciseCard({required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.asset(
            exercise.imageUrl,
            width: double.infinity,
            height: 150.0,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              exercise.name,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
