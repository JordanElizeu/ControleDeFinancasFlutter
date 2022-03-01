import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class WidgetMenuButton extends StatelessWidget {
  const WidgetMenuButton({
    Key? key,
    required this.items,
    required this.constraints,
    this.selectedValueMenuButton,
    this.functionSelectedMenuButton,
  }) : super(key: key);

  final List<String> items;
  final BoxConstraints constraints;
  final String? selectedValueMenuButton;
  final Function(dynamic value)? functionSelectedMenuButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Icon(Icons.account_balance,color: Colors.grey),
        ),
        SizedBox(width: 22),
        Expanded(
          flex: 17,
          child: DropdownButton2(
            hint: Text('Selecione uma conta'),
            items: items.map(
              (item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ).toList(),
            value: selectedValueMenuButton,
            onChanged: functionSelectedMenuButton,
            iconEnabledColor: Colors.grey,
            iconDisabledColor: Colors.blue,
            itemHeight: 40,
            buttonWidth: constraints.maxWidth * 0.80,
            buttonHeight: 60,
            buttonElevation: 0,
            buttonPadding: const EdgeInsets.only(right: 8),
            itemPadding: const EdgeInsets.only(left: 8, right: 8),
            dropdownMaxHeight: 200,
            dropdownPadding: null,
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.white,
            ),
            scrollbarRadius: const Radius.circular(10),
            scrollbarAlwaysShow: true,
            offset: const Offset(0, 0),
          ),
        ),
      ],
    );
  }
}
