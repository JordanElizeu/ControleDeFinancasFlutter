import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetInkwellIcon extends StatelessWidget {
  const WidgetInkwellIcon(
      {Key? key, required this.icon, required this.function})
      : super(key: key);

  final IconData icon;
  final Function() function;

  @override
  Widget build(BuildContext context) {
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
}
