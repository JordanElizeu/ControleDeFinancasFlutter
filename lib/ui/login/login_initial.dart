import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app_financeiro/controller/transition_controller.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:app_financeiro/ui/login/widgets/widget_animatedtext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  final String _textFinances = 'Finanças ';
  final String _textToday = 'Hoje';
  final String _textTomorrow = 'Amanhã';
  final String _textEveryday = 'Sempre';
  final String _textAccessMyAccount = 'Acessar minha conta';

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
                      width: constraints.maxWidth * 0.60,
                    ),
                    Container(
                      width: constraints.maxWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 20.0, height: 100.0),
                          FittedBox(
                            child: Text(
                              _textFinances,
                              style: TextStyle(
                                  fontSize: 30.0, color: Colors.white),
                            ),
                          ),
                          FittedBox(
                            child: DefaultTextStyle(
                              style: const TextStyle(
                                  fontSize: 30.0,
                                  fontFamily: 'Horizon',
                                  color: Colors.orange),
                              child: FittedBox(
                                child: AnimatedTextKit(
                                  animatedTexts: [
                                    animatedText(title: _textToday),
                                    animatedText(title: _textTomorrow),
                                    animatedText(title: _textEveryday),
                                  ],
                                  totalRepeatCount: 1,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: constraints.maxWidth * 0.50,
                      height: 50.0,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.deepOrange),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)))),
                        child: FittedBox(child: Text(_textAccessMyAccount)),
                        onPressed: () {
                          TransitionController().finishAndPageTransition(
                              route: Routes.LOGIN, context: context);
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
