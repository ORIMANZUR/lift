import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';
import '../timeline/controllers/timeline_controller.dart';
import '../timeline/screens/calendar_screen.dart';

class FeaturesMenuScreen extends ConsumerWidget {
  const FeaturesMenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Tools", style: Theme.of(context).textTheme.displayMedium),
              const SizedBox(height: 32),
              
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildFeatureCard(
                      context,
                      label: "Calendar",
                      icon: Icons.calendar_month_rounded,
                      color: AppTheme.primary,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CalendarScreen())),
                    ),
                    _buildFeatureCard(
                      context,
                      label: "Create Post",
                      icon: Icons.add_a_photo_rounded,
                      color: const Color(0xFFBF5AF2), // Purple
                      onTap: () {},
                    ),
                    _buildFeatureCard(
                      context,
                      label: "Simulate Trend",
                      icon: Icons.bolt_rounded,
                      color: AppTheme.alert,
                      onTap: () {
                         ref.read(timelineControllerProvider.notifier).injectTrend("Viral TikTok Sound");
                         ScaffoldMessenger.of(context).showSnackBar(
                           const SnackBar(
                             content: Text("🔥 Trend Injected! Check Home Tab."),
                             backgroundColor: AppTheme.alert,
                             behavior: SnackBarBehavior.floating,
                           )
                         );
                      },
                    ),
                    _buildFeatureCard(
                      context,
                      label: "Competitors",
                      icon: Icons.troubleshoot_rounded,
                      color: AppTheme.success,
                      onTap: () {},
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, {required String label, required IconData icon, required Color color, required VoidCallback onTap}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05)),
          boxShadow: isDark ? [] : [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(height: 16),
            Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    ).animate().scale(duration: 300.ms, curve: Curves.easeOutBack);
  }
}
