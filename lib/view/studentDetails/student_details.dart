import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:student_app/constants/color/colors.dart';
import 'package:student_app/constants/size/sizedBox.dart';
import 'package:student_app/constants/style/style.dart';
import 'package:student_app/controller/student_controller.dart';
import 'package:student_app/model/student_db.dart';
import 'package:student_app/view/studentDetails/widget/details_widget.dart';

class ScreenStudentDetails extends StatelessWidget {
  const ScreenStudentDetails({
    super.key,
    required this.index,
    required this.dataList,
  });
  final int index;
  final Student dataList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlueLight,
        centerTitle: true,
        title: Text(
          dataList.name,
          style: appBarStyle,
        ),
      ),
      body: GetBuilder<StudentController>(
        init: StudentController(),
        builder: (StudentController data) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundImage: FileImage(
                        File(dataList.image),
                      ),radius: 80,
                    ),
                  ),
                  kHeight25,
                  DetailsWidget(
                    studentDetails:
                        'Name${'     : ${dataList.name}'.toUpperCase()}',
                  ),
                  kHeight25,
                  DetailsWidget(
                    studentDetails: 'Age         : ${dataList.age}',
                  ),
                  kHeight25,
                  DetailsWidget(
                    studentDetails:
                        'Domain${'  : ${data.list[index].domain}'.toUpperCase()}',
                  ),
                  kHeight25,
                  DetailsWidget(
                    studentDetails: 'Number  : ${dataList.number}',
                  ),
                  kHeight25
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
