import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/constants/style/style.dart';
import 'package:student_app/controller/student_controller.dart';
import 'package:student_app/view/homeScreen/widget/bottomSheetIconWidget.dart';

import '../../../constants/color/colors.dart';

class PhotoBottomSheet extends StatelessWidget {
  const PhotoBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView(
        children: [
          ListTileWidget(
            onTap: () async {
              Get.find<StudentController>().getCamera();
              Get.back();
            },
            icon: const Icon(
              Icons.camera_alt,
              color: kWhite,
            ),
            title: Text(
              'Camera',
              style: bottomSheetText,
            ),
          ),
          ListTileWidget(
            onTap: () async {
              Get.find<StudentController>().getGallery();
              Get.back();
            },
            icon: const Icon(
              Icons.collections,
              color: kWhite,
            ),
            title: Text(
              'Gallery',
              style: bottomSheetText,
            ),
          ),
        ],
      ),
    );
  }
}
