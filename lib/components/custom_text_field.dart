import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    this.formKey,
    this.validator,
    this.textInputType,
    this.onChanged,
    this.onFieldSubmitted,
    this.inputDecoration,
    this.hintText,
    this.labelText,
    this.backgroundColor,
    this.inputStyle,
    this.cursorColor,
    this.controller,
    this.maxLength,
    this.counterText,
  });
  final GlobalKey<FormState> formKey;
  final TextInputType textInputType;
  final Function validator;
  final Function onChanged;
  final Function onFieldSubmitted;
  final InputDecoration inputDecoration;
  final String hintText;
  final String labelText;
  final Color backgroundColor;
  final TextStyle inputStyle;
  final Color cursorColor;
  final TextEditingController controller;
  final int maxLength;
  final String counterText;
  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidate: false,
      child: TextFormField(
        controller: controller,
        cursorColor: cursorColor,
        style: inputStyle,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          errorStyle: TextStyle(color: Colors.white),
          labelStyle: TextStyle(color: Colors.grey[300]),
          counterText: counterText,
        ),
        validator: validator,
        keyboardType: textInputType,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        maxLength: maxLength,
      ),
    );
  }
}
