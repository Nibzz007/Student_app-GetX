import 'package:flutter/material.dart';
import 'package:student_app/view/homeScreen/home_screen.dart';
import 'package:student_app/view/listScreen/studentList_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});
  
  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentSelectedIndex = 0;

  List pages = [
    const ScreenHome(),
    ListStudentScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentSelectedIndex,
        onTap: (newIndex) {
          setState(() {
            currentSelectedIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
        ],
      ),
    );
  }
}
