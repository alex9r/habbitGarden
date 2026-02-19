import 'package:flutter/material.dart';
import '../models/habit.dart'; // Make sure you have your Habit model

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Sample habits for now
  List<Habit> habits = [
    Habit(name: "Workout", type: PlantType.tree, daysInPot: 5),
    Habit(name: "Read", type: PlantType.crop, daysInPot: 12),
    Habit(name: "Journal", type: PlantType.flower, daysInPot: 28),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1️⃣ Sky
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.center,
                colors: [
                  Color(0xFF87CEEB), // Sky blue
                  Color(0xFFB3E5FC),
                ],
              ),
            ),
          ),

          // 2️⃣ Horizontal scrollable flower pots (new habits)
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  final habit = habits[index];
                  return Container(
                    width: 100,
                    margin: const EdgeInsets.only(right: 16),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.brown[200],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "🪴", 
                          style: TextStyle(fontSize: 50),
                        ),
                        const SizedBox(height: 4),
                        Flexible( // <-- add this
                          child: Text(
                            habit.name,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis, // prevent overflow
                          ),
                        ),
                        Flexible( // <-- add this
                          child: Text(
                            habit.isReadyForGarden
                                ? "🌿 Ready!"
                                : "Gestation: ${30 - habit.daysInPot}d",
                            style: const TextStyle(fontSize: 12, color: Colors.white70),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                  );
                },
              ),
            ),
          ),

          // 3️⃣ Dirt patch for future mature plants
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 250,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF795548), // lighter brown
                    Color(0xFF5D4037), // darker brown
                  ],
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
            ),
          ),

          // 4️⃣ Add Habit button
          Positioned(
            bottom: 30,
            right: 30,
            child: FloatingActionButton(
              onPressed: () {
                // TODO: Open habit selection modal
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
