import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class DropdownView extends StatelessWidget {
  final bool mandatory;
  final String label;
  final String selectedValue;
  final List<DropdownMenuItem<dynamic>> items;
  final Function(String) onChange;

  const DropdownView(
      {super.key,
      this.mandatory = false,
      required this.label,
      required this.selectedValue,
      required this.items,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 14, color: mandatory ? colorMandatory : colorBlack),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 2.0),
          child: DropdownButton(
              value: selectedValue,
              items: items,
              onChanged: (data) {
                if (data is String) {
                  onChange(data);
                }
              }),
        )
      ],
    );
  }
}
