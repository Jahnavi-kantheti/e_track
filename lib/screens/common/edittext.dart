import 'package:e_track/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditText extends StatefulWidget {
  final String? label;
  final String? hint;
  final TextEditingController controller;
  final bool isPassword;
  final int maxLines;
  final bool mandatory;
  final Function(String)? onChange;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;

  const EditText(
      {super.key,
      required this.label,
      required this.controller,
      this.maxLines = 1,
      this.mandatory = false,
      this.isPassword = false,
      this.onChange,
      this.hint,
      this.keyboardType,
      this.inputFormatters,
      this.maxLength,
      this.maxLengthEnforcement});

  @override
  State<EditText> createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  var isTogglePassword = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null
            ? Text(
                widget.label!,
                style: TextStyle(
                    fontSize: 14,
                    color: widget.mandatory ? colorMandatory : colorBlack),
              )
            : const SizedBox(),
        const SizedBox(
          height: 6,
        ),
        TextFormField(
            maxLength: widget.maxLength,
            maxLengthEnforcement: widget.maxLengthEnforcement,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            onChanged: (value) {
              if (widget.onChange != null) {
                widget.onChange!(value);
              }
            },
            maxLines: widget.maxLines,
            controller: widget.controller,
            style: const TextStyle(fontSize: 14, color: colorBlack),
            obscureText: widget.isPassword ? !isTogglePassword : false,
            decoration: InputDecoration(
              suffixIcon: widget.isPassword
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          isTogglePassword = !isTogglePassword;
                        });
                      },
                      icon: Icon(isTogglePassword
                          ? Icons.visibility_off
                          : Icons.visibility))
                  : null,
              isDense: true,
              hintText: widget.hint,
              contentPadding: const EdgeInsets.all(13),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(color: colorBlack)),
            )),
      ],
    );
  }
}
