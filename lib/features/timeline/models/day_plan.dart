import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum RoutineType {
  trendAdaptation,
  productPromo,
  authorityProof,
  communityFaq,
  beforeAfter,
  ugcStyle,
  storytime,
  mythBusting,
  tutorial,
  challenge,
  behindTheScenes,
  socialProof,
  offer,
  objectionHandling,
  empty, // For empty slots
}

extension RoutineTypeExtension on RoutineType {
  String get displayName {
    switch (this) {
      case RoutineType.trendAdaptation: return "Trend Adaptation";
      case RoutineType.productPromo: return "Product Promo";
      case RoutineType.authorityProof: return "Authority Proof";
      case RoutineType.communityFaq: return "Community/FAQ";
      case RoutineType.beforeAfter: return "Before & After";
      case RoutineType.ugcStyle: return "UGC Style";
      case RoutineType.storytime: return "Storytime";
      case RoutineType.mythBusting: return "Myth Busting";
      case RoutineType.tutorial: return "Tutorial";
      case RoutineType.challenge: return "Challenge";
      case RoutineType.behindTheScenes: return "Behind Scenes";
      case RoutineType.socialProof: return "Social Proof";
      case RoutineType.offer: return "Offer";
      case RoutineType.objectionHandling: return "Objection Handling";
      case RoutineType.empty: return "Empty";
    }
  }

  Color get color {
    switch (this) {
      case RoutineType.trendAdaptation: return const Color(0xFFFF453A); // Red (Urgent)
      case RoutineType.offer: 
      case RoutineType.productPromo: return const Color(0xFF2997FF); // Blue (Sales)
      case RoutineType.communityFaq:
      case RoutineType.socialProof: return const Color(0xFF30D158); // Green (Community)
      case RoutineType.empty: return Colors.transparent;
      default: return const Color(0xFFBF5AF2); // Purple (Content)
    }
  }
}

class PlanSlot {
  final String id;
  final RoutineType category;
  final String angle;
  final String hook;
  final String platform; // 'tiktok' | 'instagram'
  final String cta;
  final bool isPublished;

  const PlanSlot({
    required this.id,
    required this.category,
    this.angle = "",
    this.hook = "",
    this.platform = "instagram",
    this.cta = "",
    this.isPublished = false,
  });

  factory PlanSlot.empty() {
    return PlanSlot(
      id: const Uuid().v4(),
      category: RoutineType.empty,
    );
  }
  
  bool get isEmpty => category == RoutineType.empty;
}

class DayPlan {
  final DateTime date;
  final PlanSlot morningSlot;
  final PlanSlot eveningSlot;

  const DayPlan({
    required this.date,
    required this.morningSlot,
    required this.eveningSlot,
  });
}
