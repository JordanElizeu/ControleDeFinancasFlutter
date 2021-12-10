import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget textInformative({
  required String text,
  required double fontSize,
  Color? backgroundColor,
  Color? textColor,
  FontWeight? fontWeight,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 20.0),
    child: Container(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor?? Colors.black,
          backgroundColor: backgroundColor?? Colors.transparent
        ),
      ),
    ),
  );
}
