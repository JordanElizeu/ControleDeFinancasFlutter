import 'package:flutter/material.dart';

class WidgetTextInformative extends StatelessWidget {
  const WidgetTextInformative(
      {Key? key,
      this.text,
      required this.fontSize,
      this.backgroundColor,
      this.textColor,
      this.fontWeight})
      : super(key: key);

  final String? text;
  final double fontSize;
  final Color? backgroundColor;
  final Color? textColor;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        alignment: Alignment.centerLeft,
        child: Text(
          text ?? '',
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: textColor ?? Colors.black,
              backgroundColor: backgroundColor ?? Colors.transparent),
        ),
      ),
    );
  }
}
