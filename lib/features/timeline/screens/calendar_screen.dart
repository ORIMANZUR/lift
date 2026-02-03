import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../controllers/timeline_controller.dart';
import '../models/day_plan.dart';
import 'package:intl/intl.dart';
import '../widgets/slot_detail_sheet.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dayPlans = ref.watch(timelineControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("14-Day Cycle", style: Theme.of(context).textTheme.displayMedium),
        centerTitle: false,
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color ?? (isDark ? Colors.white : Colors.black)),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: dayPlans.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final plan = dayPlans[index];
          return _buildDayRow(context, plan, index);
        },
      ),
    );
  }

  Widget _buildDayRow(BuildContext context, DayPlan plan, int index) {
    final dateStr = DateFormat('EEE, MMM d').format(plan.date);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Animate nicely
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(dateStr, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.calm)),
              Text("Day ${index + 1}", style: Theme.of(context).textTheme.labelSmall),
            ],
          ),
          const SizedBox(height: 12),
          // Slots
          _buildSlotTile(context, plan, plan.morningSlot, "Morning"),
          const SizedBox(height: 8),
          _buildSlotTile(context, plan, plan.eveningSlot, "Evening"),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms, delay: (index * 50).ms).slideX(begin: 0.1, end: 0);
  }

  Widget _buildSlotTile(BuildContext context, DayPlan day, PlanSlot slot, String timeLabel) {
    final color = slot.category.color;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => SlotDetailSheet(day: day, slot: slot, timeLabel: timeLabel),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                slot.platform == 'tiktok' ? Icons.tiktok : Icons.camera_alt, // Simple icons for now
                size: 16, 
                color: color
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    slot.category.displayName, 
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: textColor)
                  ),
                  Text(
                    slot.angle, 
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(color: isDark ? Colors.white70 : Colors.black54),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: color, size: 20),
          ],
        ),
      ),
    );
  }
}
