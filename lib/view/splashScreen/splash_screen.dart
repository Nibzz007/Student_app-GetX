import 'package:flutter/material.dart';
import 'package:student_app/constants/size/sized_box.dart';
import 'package:student_app/constants/style/style.dart';
import 'package:student_app/view/bottomNav/bottom_nav.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    navigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Student Management App',
            style: splashStyle,
          ),
          kHeight25,
          Image.asset(
            'assets/images/student-management-banner-1920x1080-1.png',
          ),
        ],
      ),
    );
  }

  navigate() async {
    await Future.delayed(const Duration(seconds: 2));
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: ((context) => const BottomNav()),
      ),
    );
  }
}
