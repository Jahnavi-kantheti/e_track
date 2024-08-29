import 'dart:async';

import 'package:e_track/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/home/home_screen.dart';
import 'screens/login/login_screen.dart';
import 'utils/colors.dart';
import 'utils/location_service.dart';
import 'utils/storagebox.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await initializeService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: colorPrimary),
          useMaterial3: true,
          textTheme: GoogleFonts.redHatDisplayTextTheme()),
      home: StorageBox.instance.getToken() != '' ? HomeScreen() : LoginScreen(),
    );
  }
}
