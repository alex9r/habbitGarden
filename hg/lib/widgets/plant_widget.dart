import 'package:flutter/material.dart';
import '../models/habit.dart';

class PlantWidget extends StatelessWidget {
  final Habit habit;

  const PlantWidget({super.key, required this.habit});

  // Plant emoji based on daysInPot
  String getPlantEmoji() {
    if (habit.daysInPot < 5) return "🌱";
    if (habit.daysInPot < 10) return "🌿";
    if (habit.daysInPot < 15) return "🌳";
    if (habit.daysInPot < 20) return "🌺";
    if (habit.daysInPot < 30) return "🌸";
    return "🥀";
  }

  Color getPotColor() {
    switch (habit.type) {
      case PlantType.flower:
        return Colors.brown[400]!;
      case PlantType.crop:
        return Colors.orange[400]!;
      case PlantType.tree:
        return Colors.brown[600]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Plant emoji / placeholder

        // // Days/growth info
        // Text(
        //   habit.daysInPot >= 30 ? "Wilted" : "Days: ${habit.daysInPot}",
        //   style: const TextStyle(fontSize: 12, color: Colors.black54),
        // ),
        // const SizedBox(height: 9),

        Text(
          getPlantEmoji(),
          style: const TextStyle(fontSize: 50),
        ),
        const SizedBox(height: 8),


        // Flower pot shape
        Container(
          width: 120,
          height: 90,
          decoration: BoxDecoration(
            color: getPotColor(),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(4),
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
