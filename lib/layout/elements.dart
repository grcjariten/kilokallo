import 'package:flutter/material.dart';

class FormSwitch extends StatelessWidget {
  final bool parameter;
  final Function callBackFunction;
  final Color? color1;
  final Color? color2;
  final Color? color3;
  const FormSwitch({Key? key, required this.parameter, required this.callBackFunction, required this.color1, required this.color2, required this.color3}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch(
        activeColor: color1,
        activeTrackColor: Colors.orange,
        inactiveThumbColor: color2,
        inactiveTrackColor: color3,
        value: parameter,
        onChanged: (value) {
        callBackFunction(value);
        });
  }
}

class ChoiceBox extends StatelessWidget {
  final List<DropdownMenuItem<String>> list;
  final Function callBackFunction;
  final String? selectedValue;
  const ChoiceBox({Key? key, required this.list, required this.selectedValue, required this.callBackFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButton<String>(
        items: list,
        onChanged: (value) {
            callBackFunction(selectedValue, value);
        },
        value: selectedValue,
      ),
    );
  }
}





