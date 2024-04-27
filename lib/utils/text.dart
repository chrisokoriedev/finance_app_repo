import 'package:flutter/material.dart';

class TextWigdet extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final int? maxLine;

  const TextWigdet(
      {super.key,
      required this.text,
      this.color,
      this.fontWeight,
      this.letterSpacing,
      this.maxLine,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing),
    );
  }
}
