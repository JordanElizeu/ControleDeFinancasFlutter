import 'package:flutter/material.dart';

class WidgetCircleAvatar extends StatelessWidget {
  const WidgetCircleAvatar(
      {Key? key,
      required this.iconData,
      required this.text,
      required this.function})
      : super(key: key);

  final IconData iconData;
  final String text;
  final Function() function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, left: 1, right: 1),
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
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
