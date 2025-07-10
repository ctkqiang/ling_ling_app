import 'package:flutter/material.dart';
import 'package:ling_ling_app/presentation/components/bottom_nav_bar.dart';
import 'package:ling_ling_app/presentation/pages/fragments/dialer_page.dart';

@Deprecated("废弃，后续重构为使用Navigator进行页面跳转")
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // TODO  CHanGE
  final List<Widget> _pages = [
    const DialerPage(),
    const Center(child: Text("工具页面")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => super.setState(() => _currentIndex = index),
      ),
    );
  }
}
