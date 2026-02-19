import 'package:flutter/material.dart';
import 'screens/loading.dart';

void main() {
  runApp(const HabitGardenApp());
}

class HabitGardenApp extends StatelessWidget {
  const HabitGardenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Habit Garden',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 112, 182, 115),
        ),
      ),
      home: const LoadingScreen(),
    );
  }
}
