import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/constants/color/colors.dart';
import 'package:student_app/constants/size/sized_box.dart';
import 'package:student_app/constants/style/style.dart';
import 'package:student_app/controller/student_controller.dart';
import 'package:student_app/update/update_screen.dart';
import 'package:student_app/view/listScreen/search.dart';
import 'package:student_app/view/studentDetails/student_details.dart';

class ListStudentScreen extends StatelessWidget {
  ListStudentScreen({super.key});

  final StudentController studentController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student List',
          style: appBarStyle,
        ),
        backgroundColor: kBlueLight,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: Search(),
              );
            },
            icon: const Icon(
              Icons.search,
              size: 30,
            ),
          ),
          kWidth10
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: GetBuilder<StudentController>(
          init: StudentController(),
          builder: ((StudentController studentObject) {
            return studentObject.list.isNotEmpty
                ? ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: kBlueLight),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: ListTile(
                          onTap: () {
                            Get.to(
                              () => ScreenStudentDetails(
                                index: index,
                                dataList: studentController.list[index],
                              ),
                            );
                          },
                          leading: CircleAvatar(
                            backgroundImage: FileImage(
                              File(studentObject.list[index].image),
                            ),
                            radius: 30,
                          ),
                          title: Text(
                            studentObject.list[index].name,
                            style: studentListTitleStyle,
                          ),
                          subtitle: Text(
                            studentObject.list[index].domain,
                            style: studentListSubtitleStyle,
                          ),
                          trailing: Wrap(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Get.to(
                                    () => ScreenUpdate(
                                      index: index,
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  Get.defaultDialog(
                                      title: 'Delete',
                                      middleText: 'Do you want to delete',
                                      textConfirm: 'Ok',
                                      confirmTextColor: kWhite,
                                      onConfirm: () {
                                        studentObject.deleteStudent(
                                          studentObject.list[index].id,
                                          index,
                                        );
                                        Get.back();
                                        Get.snackbar(
                                          'title',
                                          'message',
                                          duration: const Duration(seconds: 1),
                                          titleText: Center(
                                            child: Text(
                                              'Success',
                                              style: snackTitle,
                                            ),
                                          ),
                                          messageText: Center(
                                            child: Text(
                                              'Deleted successfully',
                                              style: snackMessage,
                                            ),
                                          ),
                                          snackPosition: SnackPosition.BOTTOM,
                                          maxWidth: double.infinity,
                                          margin: const EdgeInsets.only(
                                            bottom: 5,
                                          ),
                                          backgroundColor: kLightGreen,
                                        );
                                      },
                                      textCancel: 'Cancel',
                                      onCancel: (() {
                                        // Get.offAll(ListStudentScreen());
                                      }));
                                },
                                icon: const Icon(
                                  Icons.delete,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return kHeight5;
                    },
                    itemCount: studentObject.list.length,
                  )
                : const Center(
                    child: Text(
                      'No data found',
                    ),
                  );
          }),
        ),
      ),
    );
  }
}
