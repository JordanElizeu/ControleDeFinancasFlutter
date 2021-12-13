import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget progress() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(40.0),
      child: CircularProgressIndicator(
        color: Colors.purple,
      ),
    ),
  );
}
