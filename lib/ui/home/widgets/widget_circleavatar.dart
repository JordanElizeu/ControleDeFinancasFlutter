import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget circleAvatar(
    {required IconData iconData,
    required String text,
    required Function() function}) {
  return Padding(
    padding: const EdgeInsets.only(top: 40.0,left: 1,right: 1),
    child: InkWell(
      onTap: function,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.black12,
            child: Icon(
              iconData,
              size: 40.0,
              color: Colors.black54,
            ),
            radius: 35.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
                child: Text(
              text,
              style: TextStyle(fontSize: 13),
            )),
          )
        ],
      ),
    ),
  );
}
