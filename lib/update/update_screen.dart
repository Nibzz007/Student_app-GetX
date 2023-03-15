import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/constants/color/colors.dart';
import 'package:student_app/constants/size/sized_box.dart';
import 'package:student_app/constants/style/style.dart';
import 'package:student_app/controller/student_controller.dart';
import 'package:student_app/main.dart';
import 'package:student_app/view/homeScreen/widget/bottom_sheet.dart';
import 'package:student_app/view/listScreen/student_list_screen.dart';

import '../model/student_db.dart';

class ScreenUpdate extends StatelessWidget {
  ScreenUpdate({
    super.key,
    required this.index,
    this.image,
  });

  final int index;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _domainController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  final File? image;
  @override
  Widget build(BuildContext context) {
    _nameController.text = studentController.list[index].name;
    _ageController.text = studentController.list[index].age;
    _domainController.text = studentController.list[index].domain;
    _numberController.text = studentController.list[index].number;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit',
          style: appBarStyle,
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: GetBuilder<StudentController>(
                init: StudentController(),
                builder: ((StudentController data) {
                  return SizedBox(
                    height: 150,
                    width: 150,
                    child: Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.expand,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    studentController.pickedImageFromGallery ==
                                            null
                                        ? FileImage(
                                            File(data.list[index].image),
                                          )
                                        : FileImage(
                                            File(data.pickedImageFromGallery!),
                                          ),
                                fit: BoxFit.fill,
                              ),
                              shape: BoxShape.circle,
                              color: kWhite),
                        ),
                        Positioned(
                          bottom: 20,
                          right: 120,
                          child: RawMaterialButton(
                            onPressed: () {
                              Get.bottomSheet(
                                const PhotoBottomSheet(),
                                backgroundColor: kBlueLight,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.add_a_photo,
                              color: kBlack,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  kHeight25,
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  kHeight25,
                  TextFormField(
                    controller: _ageController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  kHeight25,
                  TextFormField(
                    controller: _domainController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  kHeight25,
                  TextFormField(
                    controller: _numberController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  kHeight25,
                  ElevatedButton(
                    onPressed: () {
                      saveEditButtonClicked();
                    },
                    child: const Text(
                      'Save edit',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveEditButtonClicked() async {
    final String imageFile = studentController.pickedImageFromGallery ??
        studentController.list[index].image;
    final String domain = _domainController.text;
    final String name = _nameController.text;
    final String age = _ageController.text;
    final String number = _numberController.text;

    if (name.isEmpty || age.isEmpty || domain.isEmpty || number.isEmpty) {
      Get.snackbar(
        'title',
        'message',
        titleText: Center(
          child: Text(
            'Warning',
            style: warningTitle,
          ),
        ),
        messageText: Center(
          child: Text(
            'All fields are required',
            style: warningMessage,
          ),
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kRed,
        colorText: kBlack45,
        maxWidth: double.infinity,
      );
      return;
    } else {
      Get.back(result: ListStudentScreen());
      //Get.back();
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
            'Successfully edited',
            style: snackMessage,
          ),
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kLightGreen,
        colorText: kBlack45,
        maxWidth: double.infinity,
        //margin: const EdgeInsets.only(bottom: 15),
      );
      final Student editStudent = Student(
        id: studentController.list[index].id,
        image: imageFile,
        name: name,
        age: age,
        domain: domain,
        number: number,
      );
      studentController.updateStudent(editStudent, index);
    }
    _nameController.clear();
    _ageController.clear();
    _domainController.clear();
    _numberController.clear();
  }
}
