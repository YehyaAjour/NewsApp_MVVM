import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final TextAlign textAlign;
  final Color color;
  final bool underline;
  final FontWeight fontWeight;
  final int maxLines;
  final String fontFamily;

  CustomText(this.text,
      {this.fontSize,
      this.textAlign,
      this.color,
      this.fontWeight,
      this.underline = false,
      this.maxLines,
      this.fontFamily});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? 'استبدل هذا النص',
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.bold,
        fontSize: fontSize ?? 22,
        color: color ?? Colors.black,
        fontFamily: fontFamily ?? 'Tajawal-Regular',
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }
}
