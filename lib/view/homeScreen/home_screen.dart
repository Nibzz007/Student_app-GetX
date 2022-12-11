import 'package:flutter/material.dart';
import 'package:student_app/constants/color/colors.dart';
import 'package:student_app/constants/style/style.dart';
import 'package:get/get.dart';
import 'package:student_app/view/homeScreen/textForm.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlueLight,
        title: Text(
          'Student Details',
          style: appBarStyle,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: ElevatedButton.icon(
            icon: Icon(Icons.add),
            onPressed: (() {
              Get.to(
                () => const TextForm(),
              );
            }),
            label: Text(
              'Add Student',
              style: butttonTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
