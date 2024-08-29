import 'package:e_track/utils/colors.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function() onPress;

  const MyButton({super.key, required this.label, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Material(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: colorPrimary,
        child: Container(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Center(
            child: Text(
              label.toUpperCase().replaceAll("", " "),
              style: const TextStyle(
                  color: colorWhite, fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
