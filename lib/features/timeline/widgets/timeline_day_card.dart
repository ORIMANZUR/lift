import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../models/day_plan.dart';

enum DayStatus { past, today, future }

class TimelineDayCard extends StatelessWidget {
  final DayPlan plan;
  final DayStatus status;
  final bool isSelected;
  final VoidCallback onTap;

  const TimelineDayCard({
    super.key,
    required this.plan,
    required this.status,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Formatting
    final weekDay = _getWeekday(plan.date.weekday);
    final dayNum = plan.date.day.toString();

    // Visual State Logic
    final isToday = status == DayStatus.today;
    final isFuture = status == DayStatus.future;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    Color bgColor;
    Color textColor;

    if (isSelected) {
      bgColor = AppTheme.primary;
      textColor = Colors.white;
    } else if (isToday) {
      bgColor = isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.05);
      textColor = AppTheme.primary;
    } else {
      // Future or Past
      bgColor = Colors.transparent;
      if (isFuture) {
        textColor = isDark ? AppTheme.calm : Colors.black45;
      } else {
        textColor = isDark ? Colors.white.withValues(alpha: 0.2) : Colors.black.withValues(alpha: 0.2);
      }
    }
    
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: 300.ms,
        curve: Curves.easeOutQuint,
        width: 64,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: isToday && !isSelected
              ? Border.all(color: AppTheme.primary.withValues(alpha: 0.5), width: 1)
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              weekDay,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: textColor.withValues(alpha: isSelected ? 0.8 : 0.6),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              dayNum,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            
            // Dual Indicators (Morning / Evening)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSlotIndicator(plan.morningSlot, isSelected),
                const SizedBox(width: 4),
                _buildSlotIndicator(plan.eveningSlot, isSelected),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlotIndicator(PlanSlot slot, bool isParentSelected) {
    if (slot.isEmpty) {
      return Container(
        width: 6, 
        height: 6,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
      );
    }

    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: isParentSelected ? Colors.white : slot.category.color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: (isParentSelected ? Colors.white : slot.category.color).withValues(alpha: 0.6),
            blurRadius: 4,
            spreadRadius: 1,
          )
        ]
      ),
    );
  }

  String _getWeekday(int day) {
    const days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    return days[day - 1];
  }
}
