import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget error404({String? title}) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Image.asset('assets/images/error404.png'),
          Card(
            color: Colors.purple,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 40, right: 40),
              child: Text(
                title ?? 'Erro 404',
                style: TextStyle(color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.w700),
              ),
            ),
          )
        ],
      ),
    ),
  );
}