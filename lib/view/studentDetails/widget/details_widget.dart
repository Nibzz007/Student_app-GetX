import 'package:flutter/material.dart';
import 'package:student_app/constants/style/style.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({
    super.key,
    required this.studentDetails,
  });

  final String studentDetails;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Text(
        studentDetails,
        style: studentDetailsStyle,
      ),
    );
  }
}
