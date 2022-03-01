import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app_financeiro/controller/initial_controller.dart';
import 'package:app_financeiro/controller/login_controller.dart';
import 'package:app_financeiro/theme/theme.dart';
import 'package:app_financeiro/ui/login/widgets/widget_animatedtext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../injection/injection.dart';
import '../widgets/widget_progress.dart';

class PageInitial extends StatelessWidget {
  const PageInitial({Key? key}) : super(key: key);

  final String _textFinances = 'Controlador de Finanças';
  final String _textToday = 'Rápido, prático e gratuito';
  final String _textAccessMyAccount = 'Acessar minha conta';

  @override
  Widget build(BuildContext context) {
    InitialController loginController = getIt.get<InitialController>();
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: constraints.maxWidth * 0.70,
                                      alignment: Alignment.center,
                                      child: Text(
                                        _textFinances,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 22.0,
                                            color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      alignment: Alignment.center,
                                      width: constraints.maxWidth * 0.70,
                                      child: DefaultTextStyle(
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 10.0,
                                            fontFamily: 'Horizon',
                                            color: Colors.deepOrange),
                                        child: AnimatedTextKit(
                                          isRepeatingAnimation: true,
                                          animatedTexts: [
                                            animatedText(title: _textToday),
                                          ],
                                          totalRepeatCount: 1,
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
                                  onPressed: () async {
                                    await loginController.splashScreen(context);
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
