import 'package:e_track/models/internal/date.dart';
import 'package:e_track/screens/common/loader.dart';
import 'package:e_track/utils/storagebox.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../screens/login/login_screen.dart';
import 'colors.dart';
import 'location_service.dart';

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

String getTime(DateTime? date) {
  if (date == null) return "";
  return DateFormat("hh:mm a").format(date);
}

Future<void> logOut() async {
  await stopLocationService();
  Get.back();
  StorageBox.instance.clear();
  Get.off(() => LoginScreen());
}

showLoader() {
  Get.dialog(const Loader(), barrierDismissible: false);
}

dismissLoader() {
  if (Get.isDialogOpen == true) {
    Get.back();
  }
}
