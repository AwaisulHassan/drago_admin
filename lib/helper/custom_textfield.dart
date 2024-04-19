
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const CustomTextField({Key? key, required this.hintText,required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: hoverColor,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 12),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: hoverColor, width: 2.0),
        ),
      ),
      onSubmitted: (String value) {
        debugPrint(value);
      },
    );
  }
}