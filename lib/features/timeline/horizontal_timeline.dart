import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'widgets/timeline_day_card.dart';
import 'controllers/timeline_controller.dart';

class HorizontalTimeline extends ConsumerStatefulWidget {
  const HorizontalTimeline({super.key});

  @override
  ConsumerState<HorizontalTimeline> createState() => _HorizontalTimelineState();
}

class _HorizontalTimelineState extends ConsumerState<HorizontalTimeline> {
  late final ScrollController _scrollController;
  int _selectedIndex = 0; // Default to first item (Today)

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Now watching List<DayPlan>
    final dayPlans = ref.watch(timelineControllerProvider);

    return SizedBox(
      height: 90,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: dayPlans.length,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final plan = dayPlans[index];
          
          DayStatus status;
          if (index == 0) {
            status = DayStatus.today;
          } else if (index < 0) { 
            status = DayStatus.past;
          } else {
            status = DayStatus.future;
          }

          return TimelineDayCard(
            plan: plan,
            status: status,
            isSelected: index == _selectedIndex,
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
          ).animate(target: index == _selectedIndex ? 1 : 0)
           .scale(begin: const Offset(1,1), end: const Offset(1.05, 1.05), duration: 200.ms);
        },
      ),
    );
  }
}

