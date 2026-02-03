import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../models/day_plan.dart';

class SlotDetailSheet extends StatelessWidget {
  final DayPlan day;
  final PlanSlot slot;
  final String timeLabel;

  const SlotDetailSheet({
    super.key,
    required this.day,
    required this.slot,
    required this.timeLabel,
  });

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('EEEE, MMMM d').format(day.date);
    final color = slot.category.color;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.1))),
      ),
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  slot.platform == 'tiktok' ? Icons.tiktok : Icons.camera_alt,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(dateStr, style: TextStyle(color: Colors.white54, fontSize: 13)), 
                   const SizedBox(height: 4),
                   Text("$timeLabel Routine", style: AppTheme.textTheme.labelSmall?.copyWith(color: AppTheme.calm)),
                   Text(slot.category.displayName, style: AppTheme.textTheme.displayMedium?.copyWith(fontSize: 22)),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 32),

          // Strategy Card (Glass)
          GlassmorphicContainer(
            width: double.infinity,
            height: 280, // Approximate height
            borderRadius: 20,
            blur: 20,
            alignment: Alignment.center,
            border: 2,
            linearGradient: LinearGradient(colors: [
              Colors.white.withValues(alpha: 0.05),
              Colors.white.withValues(alpha: 0.01),
            ]),
            borderGradient: LinearGradient(colors: [
              Colors.white.withValues(alpha: 0.1),
              Colors.white.withValues(alpha: 0.05),
            ]),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   _buildDetailRow("Angle", slot.angle),
                   const Divider(color: Colors.white10, height: 24),
                   _buildDetailRow("Hook", slot.hook.isEmpty ? "AI will generate hook..." : slot.hook),
                   const Divider(color: Colors.white10, height: 24),
                   _buildDetailRow("CTA", slot.cta.isEmpty ? "Check Link in Bio" : slot.cta),
                ],
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Actions
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                     Navigator.pop(context);
                     // Mock Logic
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Regenerate"),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to Factory
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Use This"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: const TextStyle(color: Colors.white54, fontSize: 10, letterSpacing: 1.2)),
        const SizedBox(height: 4),
        Text(value, style: AppTheme.textTheme.bodyLarge?.copyWith(height: 1.4)),
      ],
    );
  }
}
