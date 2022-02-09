import 'dart:core';

import 'package:flutter/material.dart';

class defaultTextFormField extends StatelessWidget {
  TextEditingController controller;
  TextInputType keyboardType;
  Function validate;
  String labelText;
  InputBorder inputBorder;
  Color fillBoxColor;
  Function onchange;
  IconData prefix;
  Color prefixColor;
  Function prefixPressed;
  Widget suffix;
  bool isPassword = false;
  Function suffixPressed;

  defaultTextFormField({
      @required this.controller,
      @required this.keyboardType,
      @required this.validate,
      @required this.labelText,
      @required this.inputBorder,
      @required this.fillBoxColor,
      this.onchange,
      this.prefix,
      this.prefixColor,
      this.prefixPressed,
      this.suffix,
      this.isPassword,
      this.suffixPressed});

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      onChanged: onchange,
      validator: validate,
      controller: controller,
      keyboardType: keyboardType,
      // obscureText: isPassword,
      decoration: InputDecoration(
        hintText: 'بحث',
          contentPadding: EdgeInsets.all(10),
        filled: true,
        fillColor: fillBoxColor,
        labelText: labelText,
        suffixIcon: suffix ?? null,
        prefixIcon: prefix != null
            ? IconButton(
          onPressed: prefixPressed,
          icon: Icon(
            prefix,
            color: prefixColor == null ? Color(0xff009EF7) : prefixColor,
          ),
        )
            : null,
        border: inputBorder,
      ),
    );
  }
}


