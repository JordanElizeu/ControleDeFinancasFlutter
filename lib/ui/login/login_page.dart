import 'package:app_financeiro/controller/login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.purple,
        body: Center(
          child: LayoutBuilder(
            builder: (_, constraints) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: constraints.maxWidth,
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Acesse sua conta para continuar',
                          style: TextStyle(color: Colors.white, fontSize: 30.0),
                        ),
                      ),
                    ),
                    SignInButton(
                        buttonType: ButtonType.google,
                        onPressed: () {
                          LoginController().signInGoogle(context: context);
                        })
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
