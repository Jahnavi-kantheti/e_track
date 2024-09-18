import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CupertinoActivityIndicator(
      color: Colors.white,
      radius: 16,
    ));
  }
}