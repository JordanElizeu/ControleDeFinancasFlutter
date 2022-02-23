import 'package:flutter/material.dart';

class WidgetTextInformative extends StatelessWidget {
  const WidgetTextInformative({
    Key? key,
    this.text,
    required this.fontSize,
    required this.constraints,
    this.backgroundColor,
    this.textColor,
    this.fontWeight,
  }) : super(key: key);

  final String? text;
  final BoxConstraints constraints;
  final double fontSize;
  final Color? backgroundColor;
  final Color? textColor;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20.0),
      alignment: Alignment.centerLeft,
      child: Container(
        alignment: Alignment.centerLeft,
        width: constraints.maxWidth * 0.50,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text ?? '',
            style: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: textColor ?? Colors.black,
                backgroundColor: backgroundColor ?? Colors.transparent),
          ),
        ),
      ),
    );
  }
}
