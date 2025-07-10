import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ling_ling_app/presentation/pages/home_page.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  final int duration;
  const SplashPage({required this.duration, super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: widget.duration), () {
      if (super.mounted) Get.to(() => const HomePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            Lottie.asset(
              'assets/splash.json',
              animate: true,
              repeat: true,
              frameRate: FrameRate.max,
              height: 250,
              width: 250,
            ),
            const SizedBox(height: 20),
            const Text(
              '不接未知，不信忽悠，数据归你。',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 180),
          ],
        ),
      ),
    );
  }
}
