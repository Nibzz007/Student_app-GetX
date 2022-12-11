import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/constants/color/colors.dart';
import 'package:student_app/constants/size/sizedBox.dart';
import 'package:student_app/constants/style/style.dart';
import 'package:student_app/controller/student_controller.dart';
import 'package:student_app/main.dart';
import 'package:student_app/model/student_db.dart';
import 'package:student_app/view/bottomNav/bottom_nav.dart';
import 'package:student_app/view/homeScreen/widget/bottomSheet.dart';
import 'package:student_app/view/homeScreen/widget/textFormWidget.dart';

final TextEditingController namController = TextEditingController();
final TextEditingController ageController = TextEditingController();
final TextEditingController domainController = TextEditingController();
final TextEditingController numberController = TextEditingController();

File? image;

class TextForm extends StatelessWidget {
  const TextForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlueLight,
        title: Text(
          'Add student details',
          style: appBarStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: GetBuilder<StudentController>(
            init: StudentController(),
            builder: (StudentController data) {
              return SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: Stack(
                        clipBehavior: Clip.none,
                        fit: StackFit.expand,
                        children: [
                          CircleAvatar(
                            backgroundImage: data.pickedImageFromGallery != null
                                ? FileImage(
                                    File(
                                      data.pickedImageFromGallery!,
                                    ),
                                  ) as ImageProvider
                                : const AssetImage(
                                    'assets/images/no-photo.png',
                                  ),
                          ),
                          Positioned(
                            bottom: 14,
                            right: -5,
                            child: MaterialButton(
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
                                color: kBlack45,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    kHeight25,
                    TextFormWidget(
                      prefixIcon: Icons.person,
                      hintText: 'Enter your name',
                      controller: namController,
                    ),
                    kHeight25,
                    TextFormWidget(
                      prefixIcon: Icons.numbers,
                      hintText: 'Enter your age',
                      controller: ageController,
                      keyboardType: TextInputType.number,
                    ),
                    kHeight25,
                    TextFormWidget(
                      prefixIcon: Icons.developer_mode,
                      hintText: 'Enter your domain',
                      controller: domainController,
                    ),
                    kHeight25,
                    TextFormWidget(
                      prefixIcon: Icons.phone_android_outlined,
                      hintText: 'Enter your phone number',
                      controller: numberController,
                      keyboardType: TextInputType.number,
                    ),
                    kHeight25,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            submitButtonClicked();
                          },
                          child: const Text('Submit'),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> submitButtonClicked() async {
    final image = studentController.pickedImageFromGallery;
    final name = namController.text.trim();
    final age = ageController.text.trim();
    final domain = domainController.text.trim();
    final number = numberController.text.trim();

    if (name.isEmpty || age.isEmpty || domain.isEmpty || number.isEmpty) {
      Get.snackbar(
        'Warning', 
        'All fields are required',
          duration: Duration(seconds: 1),
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
          colorText: kWhite,
          maxWidth: double.infinity,
          margin: const EdgeInsets.all(10));
    } else {
      final Student addToDataBase = Student(
        image: image!,
        name: name,
        age: age,
        domain: domain,
        number: number,
      );

      Get.offAll(() => const BottomNav());
      Get.snackbar(
        'title', 
        'message',
        duration: Duration(seconds: 1),
          titleText: Center(
            child: Text(
              'Success',
              style: snackTitle,
            ),
          ),
          messageText: Center(
            child: Text(
              'Successfully added',
              style: snackMessage,
            ),
          ),
          snackPosition: SnackPosition.BOTTOM,
          maxWidth: double.infinity,
          backgroundColor: kLightGreen,
          margin: const EdgeInsets.all(10));
      studentController.pickedImageFromGallery = null;
      namController.clear();
      ageController.clear();
      domainController.clear();
      numberController.clear();
      studentController.addStudentList(addToDataBase);
    }
  }
}
