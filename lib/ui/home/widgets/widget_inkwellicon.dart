import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget widgetInkwellIcon({required IconData icon, required Function() function}){
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: InkWell(
      onTap: function,
      child: Icon(
        icon,
        color: Colors.white,
      ),
    ),
  );
}