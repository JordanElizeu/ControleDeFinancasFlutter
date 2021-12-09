import 'dart:ui';
import 'package:app_financeiro/ui/initial/widgets/widget_circleavatar.dart';
import 'package:app_financeiro/ui/initial/widgets/widget_textinformative.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageInitial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                color: Colors.purple,
                width: constraints.maxWidth,
                height: constraints.maxHeight * 0.25,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 25.0,
                            child: Icon(
                              Icons.person_outline,
                              size: 25,
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.info_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Olá, user',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    textInformative(text: 'Conta', fontSize: 22.0),
                    textInformative(
                        text: 'R\$ 0',
                        fontSize: 27.0,
                        fontWeight: FontWeight.w400),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        circleAvatar(
                            iconData: Icons.arrow_circle_up_rounded,
                            text: "Depositar"),
                        circleAvatar(
                          iconData: Icons.arrow_circle_down,
                          text: "Retirar",
                        ),
                        circleAvatar(
                          iconData: Icons.assessment_outlined,
                          text: "Transações",
                        ),
                      ],
                    ),
                    Card(
                      color: Colors.white54,
                      child: ListTile(
                        title: Container(
                          alignment: Alignment.center,
                          child: Text('Anotações'),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
