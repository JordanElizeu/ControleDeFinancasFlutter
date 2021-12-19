import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetProgress extends StatelessWidget {
  const WidgetProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: CircularProgressIndicator(
          color: Colors.purple,
        ),
      ),
    );
  }
}
