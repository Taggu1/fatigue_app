class FatigueData {
  final int decisionsMade;
  final double hoursAwake;
  final int taskSwitches;
  final int caffeineCups;
  final double sleepHours;
  final int stressLevel;

  FatigueData({
    required this.decisionsMade,
    required this.hoursAwake,
    required this.taskSwitches,
    required this.caffeineCups,
    required this.sleepHours,
    required this.stressLevel,
  });

  Map<String, dynamic> toJson() {
    return {
      'decisions_made': decisionsMade,
      'hours_awake': hoursAwake,
      'task_switches': taskSwitches,
      'caffeine_cups': caffeineCups,
      'sleep_hours': sleepHours,
      'stress_level': stressLevel,
    };
  }
}
