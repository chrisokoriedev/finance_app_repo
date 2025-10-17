import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final int? maxLine;
  final TextAlign? textAlign;

  const TextWidget(
      {super.key,
      required this.text,
      this.color,
      this.fontWeight,
      this.letterSpacing,
      this.maxLine,
      this.fontSize,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing),
    );
  }
}
