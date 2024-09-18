import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:disable_battery_optimization/disable_battery_optimization.dart';
import 'package:e_track/screens/common/loader.dart';
import 'package:e_track/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/login/login_screen.dart';
import 'utils/colors.dart';
import 'utils/location_service.dart';
import 'utils/storagebox.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await initializeService();
  await handleLocationPermission(true);
  if (Platform.isAndroid) {
    bool? notifyPerm = await FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.areNotificationsEnabled();
    if (notifyPerm != null && notifyPerm == false) {
      await FlutterLocalNotificationsPlugin()
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }

    bool? isBatteryOptimizationDisabled =
        await DisableBatteryOptimization.isBatteryOptimizationDisabled;
    if (isBatteryOptimizationDisabled != null &&
        isBatteryOptimizationDisabled == false) {
      await DisableBatteryOptimization.showDisableBatteryOptimizationSettings();
    }
  }
  final deviceInfoPlugin = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    final deviceInfo = await deviceInfoPlugin.androidInfo;
    await StorageBox.instance.setDeviceID(deviceInfo.id);
  } else if (Platform.isIOS) {
    final deviceInfo = await deviceInfoPlugin.iosInfo;
    await StorageBox.instance.setDeviceID(deviceInfo.identifierForVendor);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: colorPrimary),
          useMaterial3: true,
          textTheme: GoogleFonts.redHatDisplayTextTheme()),
      home: LoginScreen(),
    );
  }
}
