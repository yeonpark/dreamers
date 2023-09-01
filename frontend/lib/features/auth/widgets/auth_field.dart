import 'package:dreamers/constants/constants.dart';
import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const AuthField({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Pallete.contentTextColor,
            width: 3,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Pallete.navigationColor
          ),
        ),
        contentPadding: const EdgeInsets.all(22),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}