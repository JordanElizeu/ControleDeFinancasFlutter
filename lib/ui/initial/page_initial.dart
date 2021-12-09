import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageInitial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: constraints.maxHeight * 0.30,
                width: constraints.maxWidth * 0.90,
                child: Card(
                  color: Colors.purple,
                  child: Center(
                    child: Text(
                      '0',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.0
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
