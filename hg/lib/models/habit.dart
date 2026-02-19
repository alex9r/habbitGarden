enum PlantType {
  flower,
  crop,
  tree,
}

enum HabitPeriod {
  day,
  week,
  month,
}

class Habit {
  final String name;
  final PlantType type;

  int health;
  int weedLevel;
  bool completedToday;
  int daysInPot;

  // =========================
  // NEW FIELDS FOR ACCOUNTABILITY
  // =========================
  int targetFrequency; // number of times user aims to do this habit in the period
  HabitPeriod period;  // day, week, or month

  Habit({
    required this.name,
    required this.type,
    this.health = 0,
    this.weedLevel = 0,
    this.completedToday = false,
    this.daysInPot = 0,
    this.targetFrequency = 1,
    this.period = HabitPeriod.day,
  });

  bool get isReadyForGarden => daysInPot >= 30;

  // =========================
  // Core Update Logic (Daily)
  // =========================
  void updateHealth({int completedCount = 0}) {
    // completedCount = how many times user actually did the habit today/this period
    if (completedCount >= targetFrequency) {
      health += growthRate;
    } else {
      health -= decayRate;
    }

    _clampHealth();
    completedToday = false;
  }

  // =========================
  // Weed System (Missed Logins)
  // =========================
  void applyWeeds(int missedDays) {
    weedLevel += missedDays;

    // Optional: weeds also damage health slowly
    health -= missedDays * 5;

    _clampHealth();
  }

  void clearWeeds() {
    weedLevel = 0;
  }

  // =========================
  // Growth Configuration
  // =========================
  int get maxHealth {
    switch (type) {
      case PlantType.flower:
        return 100;
      case PlantType.crop:
        return 150;
      case PlantType.tree:
        return 300;
    }
  }

  int get growthRate {
    switch (type) {
      case PlantType.flower:
        return 15;
      case PlantType.crop:
        return 10;
      case PlantType.tree:
        return 5;
    }
  }

  int get decayRate {
    switch (type) {
      case PlantType.flower:
        return 15;
      case PlantType.crop:
        return 10;
      case PlantType.tree:
        return 5;
    }
  }

  // =========================
  // Growth State
  // =========================
  double get growthPercent => health / maxHealth;

  String get growthStage {
    if (health == 0) return "Dead";
    if (growthPercent >= 0.8) return "Thriving";
    if (growthPercent >= 0.5) return "Growing";
    if (growthPercent >= 0.2) return "Wilting";
    return "Dying";
  }

  bool get isDead => health == 0;

  // =========================
  // Internal Helpers
  // =========================
  void _clampHealth() {
    if (health > maxHealth) health = maxHealth;
    if (health < 0) health = 0;
  }
}
