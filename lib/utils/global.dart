import 'package:e_track/models/internal/date.dart';
import 'package:e_track/screens/common/loader.dart';
import 'package:e_track/utils/storagebox.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

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
  String deviceId = StorageBox.instance.getDeviceID();
  await StorageBox.instance.clear();
  await StorageBox.instance.setDeviceID(deviceId);
  Get.back();
  Get.off(() => LoginScreen());
}

extension StringExtensions on String? {
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }

  bool get isNotNullOrEmpty {
    return !isNullOrEmpty;
  }
}

DropdownMenuItem<dynamic> defaultDropdown() {
  return const DropdownMenuItem(
    value: '-1',
    child: Text('Select', style: TextStyle(fontSize: 14, color: colorBlack)),
  );
}

Future<bool> isInternetAvailable() async {
  bool isConnected = await InternetConnectionChecker().hasConnection;
  return isConnected;
}

final _logger = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

void kPrintLog(Object? message) {
  if (kDebugMode) {
    _logger.i(message);
  }
}

showLoader() {
  kPrintLog("showloader");
  Get.dialog(const PopScope(canPop: false, child: Loader()),
      barrierDismissible: false);
}

dismissLoader() {
  kPrintLog("dismiss loader 1");
  if (Get.isDialogOpen == true) {
    kPrintLog("dismiss loader 2");
    Navigator.of(Get.overlayContext!, rootNavigator: true).pop();
  }
}
