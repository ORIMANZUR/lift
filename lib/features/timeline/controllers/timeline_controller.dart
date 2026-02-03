import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/day_plan.dart';

final timelineControllerProvider = NotifierProvider<TimelineController, List<DayPlan>>(() {
  return TimelineController();
});

class TimelineController extends Notifier<List<DayPlan>> {
  
  @override
  List<DayPlan> build() {
    return _generate14DayCycle();
  }

  List<DayPlan> _generate14DayCycle() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final List<DayPlan> days = [];
    final random = Random();
    final routines = RoutineType.values.where((e) => e != RoutineType.empty && e != RoutineType.trendAdaptation).toList();

    // Create a 14-day LIFT14 Cycle
    for (int i = 0; i < 14; i++) {
      final date = today.add(Duration(days: i));
      
      // Assign Random Routines for Morning & Evening (Mocking AI Strategy)
      final morningRoutine = routines[random.nextInt(routines.length)];
      final eveningRoutine = routines[random.nextInt(routines.length)];

      days.add(DayPlan(
        date: date,
        morningSlot: PlanSlot(
          id: const Uuid().v4(),
          category: morningRoutine,
          angle: "Angle for ${morningRoutine.displayName}",
          platform: 'instagram', // Default
        ),
        eveningSlot: PlanSlot(
          id: const Uuid().v4(),
          category: eveningRoutine,
          angle: "Angle for ${eveningRoutine.displayName}",
          platform: 'tiktok', // Mix it up
        ),
      ));
    }
    return days;
  }
  
  // LIFT14 Trend Injection: Overwrites a slot with "Trend Adaptation"
  void injectTrend(String trendName) {
    if (state.length < 2) return; // Safety check

    // "Cheat Mode": We find the morning slot of Day 2 (Tomorrow) and force a Trend Ad
    final targetIndex = 1; // Tomorrow
    final currentDay = state[targetIndex];
    
    final newMorningSlot = PlanSlot(
      id: const Uuid().v4(),
      category: RoutineType.trendAdaptation,
      angle: "Viral Twist: $trendName",
      hook: "Stop scrolling! $trendName is taking over...",
      platform: 'tiktok', // Trends are usually video
      cta: "Check link in bio",
    );

    final updatedDay = DayPlan(
      date: currentDay.date,
      morningSlot: newMorningSlot,
      eveningSlot: currentDay.eveningSlot, 
    );

    // Update state
    final newState = [...state];
    newState[targetIndex] = updatedDay;
    state = newState;
  }
}
