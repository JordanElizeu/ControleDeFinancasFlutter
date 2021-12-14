import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app_financeiro/controller/controller.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:app_financeiro/ui/login/widgets/widget_animatedtext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                    Image.asset(
                      'assets/images/foguete.png',
                      height: constraints.maxHeight * 0.60,
                      width: constraints.maxWidth * 0.70,
                    ),
                    Container(
                      width: constraints.maxWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 20.0, height: 100.0),
                          FittedBox(
                            child: const Text(
                              'Finanças ',
                              style:
                                  TextStyle(fontSize: 30.0, color: Colors.white),
                            ),
                          ),
                          FittedBox(
                            child: DefaultTextStyle(
                              style: const TextStyle(
                                  fontSize: 30.0,
                                  fontFamily: 'Horizon',
                                  color: Colors.orange),
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  animatedText(title: 'Hoje'),
                                  animatedText(title: 'Amanhã'),
                                  animatedText(title: 'Sempre'),
                                ],
                                totalRepeatCount: 1,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: constraints.maxWidth*0.50,
                      height: 50.0,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.deepOrange),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)))),
                        child: Text('Acessar minha conta'),
                        onPressed: () {
                          Controller(context).finishAndPageTransition(route: Routes.LOGIN);
                        },
                      ),
                    ),
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
