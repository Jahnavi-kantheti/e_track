import 'package:e_track/utils/colors.dart';
import 'package:flutter/material.dart';

class EditText extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final int maxLines;
  final bool mandatory;

  const EditText(
      {super.key,
      required this.label,
      required this.controller,
      this.maxLines = 1,
      this.mandatory = false,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 14, color: mandatory ? colorMandatory : colorBlack),
        ),
        const SizedBox(
          height: 6,
        ),
        TextFormField(
            maxLines: maxLines,
            controller: controller,
            style: const TextStyle(fontSize: 14, color: colorBlack),
            obscureText: isPassword,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(13),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(color: colorBlack)),
            )),
      ],
    );
  }
}
