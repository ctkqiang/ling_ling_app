import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // 强制所有图标白色（无论主题）
    const Color iconColor = Colors.white;

    return NavigationBar(
      backgroundColor: Colors.pink.shade100,
      indicatorColor: Colors.pink.shade200,
      surfaceTintColor: Colors.transparent,
      selectedIndex: currentIndex,
      animationDuration: const Duration(milliseconds: 300),
      height: 70,
      onDestinationSelected: onTap,
      indicatorShape: StadiumBorder(side: BorderSide.none),
      key: const ValueKey(':|>bottom-nav'),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      elevation: 0,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.phone, color: iconColor),
          selectedIcon: Icon(Icons.phone_android, color: iconColor),
          label: '电话',
        ),
        NavigationDestination(
          icon: Icon(Icons.build, color: iconColor),
          selectedIcon: Icon(Icons.build_circle, color: iconColor),
          label: '工具',
        ),
      ],
    );
  }
}
