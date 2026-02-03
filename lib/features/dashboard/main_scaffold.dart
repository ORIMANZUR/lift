import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'dashboard_screen.dart';
import 'features_menu_screen.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const FeaturesMenuScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          // 1. Active Screen
          IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),

          // 2. Floating Glass Dock
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20 + MediaQuery.of(context).padding.bottom),
              child: GlassmorphicContainer(
                width: 200,
                height: 70,
                borderRadius: 35,
                blur: 30,
                alignment: Alignment.center,
                border: 2,
                linearGradient: LinearGradient(
                  colors: isDark 
                    ? [Colors.white.withValues(alpha: 0.15), Colors.white.withValues(alpha: 0.05)]
                    : [Colors.white.withValues(alpha: 0.8), Colors.white.withValues(alpha: 0.6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderGradient: LinearGradient(
                  colors: isDark
                    ? [Colors.white.withValues(alpha: 0.2), Colors.white.withValues(alpha: 0.05)]
                    : [Colors.white.withValues(alpha: 0.9), Colors.white.withValues(alpha: 0.5)],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildDockIcon(0, Icons.home_rounded, isDark),
                    _buildDockIcon(1, Icons.grid_view_rounded, isDark),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDockIcon(int index, IconData icon, bool isDark) {
    final isSelected = _currentIndex == index;
    final activeColor = isDark ? Colors.white : Colors.black;
    final inactiveColor = isDark ? Colors.white54 : Colors.black45;
    final activeBg = isDark ? Colors.white.withValues(alpha: 0.2) : Colors.black.withValues(alpha: 0.1);

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? activeBg : Colors.transparent,
          shape: BoxShape.circle,
          boxShadow: isSelected ? [
            BoxShadow(
              color: activeBg,
              blurRadius: 15,
              spreadRadius: 1,
            )
          ] : [],
        ),
        child: Icon(
          icon,
          color: isSelected ? activeColor : inactiveColor,
          size: 28,
        ),
      ),
    );
  }
}
