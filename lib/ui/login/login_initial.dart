import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app_financeiro/controller/login_controller.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:app_financeiro/theme/theme.dart';
import 'package:app_financeiro/ui/login/widgets/widget_animatedtext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../injection/injection.dart';
import '../../utils/transition_page.dart';
import '../widgets/widget_progress.dart';

class PageInitial extends StatelessWidget {
  const PageInitial({Key? key}) : super(key: key);

  final String _textFinances = 'Finanças ';
  final String _textToday = 'Hoje';
  final String _textTomorrow = 'Amanhã';
  final String _textEveryday = 'Sempre';
  final String _textAccessMyAccount = 'Acessar minha conta';

  @override
  Widget build(BuildContext context) {
    final TransitionPage transitionController = getIt.get<TransitionPage>();
    Get.put(getIt.get<LoginController>());
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Center(
          child: LayoutBuilder(
            builder: (_, constraints) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/foguete.png',
                      height: constraints.maxHeight * 0.50,
                      width: constraints.maxWidth * 0.50,
                    ),
                    const SizedBox(height: 70),
                    GetBuilder<LoginController>(
                      builder: ((controller) {
                        if (controller.pageIsLoading) {
                          return Column(
                            children: [
                              Container(
                                width: constraints.maxWidth,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 20.0),
                                    FittedBox(
                                      child: Text(
                                        _textFinances,
                                        style: TextStyle(
                                            fontSize: 30.0,
                                            color: Colors.white),
                                      ),
                                    ),
                                    FittedBox(
                                      child: DefaultTextStyle(
                                        style: const TextStyle(
                                            fontSize: 30.0,
                                            fontFamily: 'Horizon',
                                            color: Colors.deepOrange),
                                        child: FittedBox(
                                          child: AnimatedTextKit(
                                            animatedTexts: [
                                              animatedText(title: _textToday),
                                              animatedText(
                                                  title: _textTomorrow),
                                              animatedText(
                                                  title: _textEveryday),
                                            ],
                                            totalRepeatCount: 1,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 40),
                              Container(
                                width: constraints.maxWidth * 0.50,
                                height: 50.0,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              buttonColor),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      30.0)))),
                                  child: FittedBox(
                                      child: Text(_textAccessMyAccount)),
                                  onPressed: () {
                                    transitionController
                                        .finishAndPageTransition(
                                            route: Routes.LOGIN,
                                            context: context);
                                  },
                                ),
                              ),
                            ],
                          );
                        } else {
                          controller.pageLoadingState();
                          return WidgetProgress(colors: Colors.white);
                        }
                      }),
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
