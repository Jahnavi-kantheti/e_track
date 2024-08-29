import 'package:e_track/models/internal/date.dart';
import 'package:e_track/screens/common/loader.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'colors.dart';

void showToast({required String message}) {
  Get.showSnackbar(
    GetSnackBar(
      message: message,
      backgroundColor: colorBlack,
      duration: const Duration(seconds: 5),
    ),
  );
}

Date getDate() {
  DateTime now = DateTime.now();
  String time = DateFormat('hh:mm a').format(now);
  String dayOfWeek = DateFormat('EEEE').format(now);
  String formattedDate = DateFormat('d MMMM y').format(now);
  return Date(time: time, date: formattedDate, day: dayOfWeek);
}

showLoader() {
  Get.dialog(const Loader(), barrierDismissible: false);
}

dismissLoader() {
  if (Get.isDialogOpen == true) {
    Get.back();
  }
}
