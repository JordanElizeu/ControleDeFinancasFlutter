import 'package:flutter/material.dart';

class WidgetProgress extends StatelessWidget {
  const WidgetProgress({Key? key, this.colors}) : super(key: key);
  final Color? colors;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: CircularProgressIndicator(
          color: colors ?? Colors.purple,
        ),
      ),
    );
  }
}
