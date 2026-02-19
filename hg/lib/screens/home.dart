import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../models/habit.dart';
import '../widgets/plant_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Habit> habits = [
    Habit(name: "Workout", type: PlantType.tree, daysInPot: 2),
    Habit(name: "Read", type: PlantType.crop, daysInPot: 8),
    Habit(name: "Journal", type: PlantType.flower, daysInPot: 18),
    Habit(name: "Meditate", type: PlantType.flower, daysInPot: 32),
  ];

  final PageController _pageController = PageController(viewportFraction: 0.6);

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final page = _pageController.page ?? 0;
      final newPage = page.round();
      // Only update if the page index actually changed
      if (_currentPage != newPage) {
        setState(() {
          _currentPage = newPage;
        });
      }
    });
  }


  void _addHabit() {
    String name = "";
    PlantType type = PlantType.flower;
    int targetFrequency = 1;
    HabitPeriod period = HabitPeriod.day;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Habit"),
          content: SizedBox(
            height: 250,
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: "Habit Name"),
                  onChanged: (val) => name = val,
                ),
                const SizedBox(height: 12),
                DropdownButton<PlantType>(
                  value: type,
                  items: PlantType.values
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.name),
                          ))
                      .toList(),
                  onChanged: (val) => setState(() => type = val!),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 100,
                      child: CupertinoPicker(
                        scrollController:
                            FixedExtentScrollController(initialItem: targetFrequency - 1),
                        itemExtent: 30,
                        onSelectedItemChanged: (val) => targetFrequency = val + 1,
                        children:
                            List.generate(10, (index) => Center(child: Text("${index + 1}"))),
                      ),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: CupertinoPicker(
                        scrollController: FixedExtentScrollController(
                            initialItem: HabitPeriod.values.indexOf(period)),
                        itemExtent: 30,
                        onSelectedItemChanged: (val) => period = HabitPeriod.values[val],
                        children: HabitPeriod.values
                            .map((e) => Center(child: Text(e.name)))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                if (name.isNotEmpty) {
                  setState(() {
                    habits.add(Habit(
                      name: name,
                      type: type,
                      daysInPot: 0,
                      targetFrequency: targetFrequency,
                      period: period,
                    ));
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          // Dynamic header at top
          Positioned(
            top: 50, // space from top
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Habit Name
                Text(
                  habits.isNotEmpty
                      ? habits[_pageController.hasClients
                          ? (_pageController.page ?? _pageController.initialPage.toDouble()).round()
                          : 0]
                          .name
                      : "",
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                // Days in pot under the habit name
                Text(
                  habits.isNotEmpty
                      ? "Days: ${habits[_pageController.hasClients
                          ? (_pageController.page ?? _pageController.initialPage.toDouble()).round()
                          : 0].daysInPot}"
                      : "",
                  style: const TextStyle(
                      fontSize: 18, color: Colors.black54),
                ),

            ],
            ),
          ),

          // PageView for plants
          Positioned(
            top: screenHeight * 0.37, // adjust as needed
            left: 0,
            right: 0,
            child: SizedBox(
              height: 250,
              child: PageView.builder(
                controller: _pageController,
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  final habit = habits[index];

                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      double value = 1.0;
                      if (_pageController.hasClients) {
                        final page =
                            _pageController.page ?? _pageController.initialPage.toDouble();
                        value = (1 - ((page - index).abs() * 0.3)).clamp(0.8, 1.0);
                      }

                      return Center(
                        child: SizedBox(
                          height: 220 * value,
                          width: 180 * value,
                          child: child,
                        ),
                      );
                    },
                    child: PlantWidget(habit: habit),
                  );
                },
              ),
            ),
          ),

          // Fixed shelf at bottom
          Positioned(
            bottom: screenHeight * 0.1,
            left: 0,
            right: 0,
            child: Container(
              height: 200,
              width: double.infinity,
              color: Colors.brown[300],
              child: const Center(
                child: Text(
                  "",
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addHabit,
        child: const Icon(Icons.add),
      ),
    );

  }
}
