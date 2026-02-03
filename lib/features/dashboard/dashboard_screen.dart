import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../../core/theme/app_theme.dart';
import '../timeline/horizontal_timeline.dart';
import '../timeline/controllers/timeline_controller.dart';
import '../timeline/models/day_plan.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Welcome Header
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Welcome Back,", style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(height: 4),
                        Text("Orizg", style: Theme.of(context).textTheme.displayMedium),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.2)),
                      ),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        child: const Icon(Icons.person),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // 2. "My Content" Section (The Timeline)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("My Content", style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 20)),
                    TextButton(
                      onPressed: () {},
                      child: Text("See All", style: TextStyle(color: AppTheme.primary)),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              
              // Timeline Widget
              const HorizontalTimeline().animate().fadeIn(duration: 600.ms).slideX(begin: 0.2, end: 0),

              const SizedBox(height: 32),

              // 3. Today's Routines (Replacing Actions)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Today's Routines", style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 20)),
                    const SizedBox(height: 16),
                    _buildTodayRoutines(context, ref),
                  ],
                ),
              ).animate().slideY(begin: 0.2, end: 0, duration: 600.ms, delay: 200.ms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTodayRoutines(BuildContext context, WidgetRef ref) {
    // Get the full plan
    final dayPlans = ref.watch(timelineControllerProvider);
    
    // Safety check
    if (dayPlans.isEmpty) {
      return const Center(child: Text("No Plan Generated"));
    }

    // Today is always index 0 in our logic
    final todayPlan = dayPlans[0]; 

    return Column(
      children: [
        _buildRoutineCard(context, todayPlan.morningSlot, "Morning"),
        const SizedBox(height: 12),
        _buildRoutineCard(context, todayPlan.eveningSlot, "Evening"),
      ],
    );
  }

  Widget _buildRoutineCard(BuildContext context, PlanSlot slot, String timeLabel) {
    if (slot.isEmpty) return const SizedBox.shrink();

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = slot.category.color;
    final textColor = isDark ? Colors.white : const Color(0xFF1D1D1F);
    final secondaryTextColor = isDark ? Colors.white70 : const Color(0xFF1D1D1F).withValues(alpha: 0.7);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            // 1. Ambient Glow (Under layer)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      color.withValues(alpha: isDark ? 0.15 : 0.05),
                      Colors.transparent,
                    ],
                    center: Alignment.center,
                    radius: 0.8,
                  ),
                ),
              ),
            ),

            // 2. Glass Card
            GlassmorphicContainer(
              width: constraints.maxWidth,
              height: 180, 
              borderRadius: 24,
              blur: 20,
              alignment: Alignment.center,
              border: 2,
              linearGradient: LinearGradient(
                colors: isDark 
                  ? [Colors.white.withValues(alpha: 0.1), Colors.white.withValues(alpha: 0.02)]
                  : [Colors.white.withValues(alpha: 0.6), Colors.white.withValues(alpha: 0.3)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderGradient: LinearGradient(
                colors: isDark
                  ? [Colors.white.withValues(alpha: 0.15), Colors.white.withValues(alpha: 0.05)]
                  : [Colors.white.withValues(alpha: 0.9), Colors.white.withValues(alpha: 0.4)],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header: Time + Icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.2), 
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: color.withValues(alpha: 0.3)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.wb_sunny_rounded, size: 14, color: color), 
                              const SizedBox(width: 6),
                              Text(timeLabel.toUpperCase(), style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Icon(
                          slot.platform == 'tiktok' ? Icons.tiktok : Icons.camera_alt,
                          color: secondaryTextColor,
                          size: 20,
                        ),
                      ],
                    ),
                    
                    const Spacer(),
                    
                    // Main Content
                    Text(
                      slot.category.displayName,
                      style: AppTheme.textTheme.displayMedium?.copyWith(fontSize: 22, color: textColor),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      slot.hook.isNotEmpty ? "\"${slot.hook}\"" : "Generating hook...",
                      style: AppTheme.textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic, 
                        color: textColor.withValues(alpha: 0.8)
                      ),
                    ),

                    const SizedBox(height: 16),
                    
                    // Context / Angle
                    Row(
                      children: [
                        Icon(Icons.info_outline, size: 14, color: secondaryTextColor),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            slot.angle,
                            style: AppTheme.textTheme.labelSmall?.copyWith(color: secondaryTextColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}

