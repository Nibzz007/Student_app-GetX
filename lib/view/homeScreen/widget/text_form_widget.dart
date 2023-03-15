import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormWidget extends StatelessWidget {
  const TextFormWidget(
      {super.key,
      required this.prefixIcon,
      required this.hintText,
      this.keyboardType = TextInputType.name,
      required this.controller,
      this.inputFormatters});

  final IconData prefixIcon;
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon),
          hintText: hintText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        inputFormatters: inputFormatters,
        validator: (String? value) {
          if (value == null) {
            return 'Field cannot be empty';
          }
          return null;
        });
  }
}
