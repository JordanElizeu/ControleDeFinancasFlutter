import 'package:flutter/material.dart';

class Error404 extends StatelessWidget {
  const Error404({Key? key, this.title}) : super(key: key);

  final String? title;
  final String textDefaultError = 'Erro 404';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
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
                  child: FittedBox(
                    child: Text(
                      title ?? textDefaultError,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
