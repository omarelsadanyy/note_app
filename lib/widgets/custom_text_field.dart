import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.onsaved,
    this.hintText,
    this.onChanged,
    this.decoration,
    this.cursorColor,
    this.maxLines = 1,
  });

  final String? hintText;
  final int maxLines;
  final Function(String)? onChanged;
  final InputDecoration? decoration;
  final Color? cursorColor;
  final Function(String?)? onsaved;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onSaved: onsaved,
      cursorColor: cursorColor,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Please enter a value';
        } else {
          return null;
        }
      },
      maxLines: maxLines,
      onChanged: onChanged,
      decoration: decoration ??
           InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
    );
  }
}