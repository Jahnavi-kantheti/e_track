import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';

Widget swipesView({required String inTime, required String outTime}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Swipes: ",
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w800, color: colorPrimaryDark),
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: Get.width * 0.1,
          ),
          Text(
            "First IN Time:",
            style: TextStyle(color: colorBlack),
          ),
          SizedBox(
            width: Get.width * 0.24,
          ),
          Text(
            inTime,
            style: TextStyle(fontWeight: FontWeight.w600, color: colorBlack),
          ),
          Spacer(),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: Get.width * 0.1,
          ),
          Text(
            "Last OUT Time:",
            style: TextStyle(color: colorBlack),
          ),
          SizedBox(
            width: Get.width * 0.2,
          ),
          Text(outTime,
              style: TextStyle(fontWeight: FontWeight.w600, color: colorBlack)),
          Spacer(),
        ],
      ),
    ],
  );
}
