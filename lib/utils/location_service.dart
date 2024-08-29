import 'dart:io';
import 'dart:ui';

import 'package:e_track/network/api_service.dart';
import 'package:e_track/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';

import '../models/user.dart';
import 'strings.dart';

Future<bool> handleLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    showToast(
        message: 'Location services are disabled. Please enable the services');
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      showToast(message: 'Location permissions are denied');
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    showToast(
        message:
            'Location permissions are permanently denied, we cannot request permissions.');
    return false;
  }
  return true;
}

Future<Position?> getCurrentPosition() async {
  try {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high, forceAndroidLocationManager: true);
  } catch (e) {
    print(e);
    return null;
  }
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  /// OPTIONAL, using custom notification channel id
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    appName, // id
    notificationTitle, // title
    importance: Importance.high, // importance must be at low or higher level
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (Platform.isIOS || Platform.isAndroid) {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(),
        android: AndroidInitializationSettings(notificationIconName),
      ),
    );
  }

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: false,
      isForegroundMode: true,

      notificationChannelId: appName,
      initialNotificationTitle: notificationTitle,
      initialNotificationContent: 'Initializing',
      foregroundServiceNotificationId: channelID,
      foregroundServiceType: AndroidForegroundType.location,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: false,

      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );
}

// to ensure this is executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  getLocation(flutterLocalNotificationsPlugin);

  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();

  // For flutter prior to version 3.0.0
  // We have to register the plugin manually

  /// OPTIONAL when use custom notification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  // bring to foreground
  if (service is AndroidServiceInstance) {
    if (await service.isForegroundService()) {
      /// OPTIONAL for use custom notification
      /// the notification id must be equals with AndroidConfiguration when you call configure() method.
      getLocation(flutterLocalNotificationsPlugin);
    }
  }
}

Future<void> getLocation(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  Position? position = await getCurrentPosition();
  String body = "";
  if (position != null) {
    body = "${position.latitude} , ${position.longitude}";
    print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');

    // API Call
    final response =
    await ApiService.instance.request('/users', DioMethod.get);
    final List<UserResponse> users = response.data
        .map<UserResponse>((e) => UserResponse.fromJson(e))
        .toList();

    print(users.map((e) => e.name));

  } else {
    body = "Error";
    print('FLUTTER BACKGROUND SERVICE Error: ${DateTime.now()}');
  }

  flutterLocalNotificationsPlugin.show(
    channelID,
    notificationTitle,
    body,
    const NotificationDetails(
      android: AndroidNotificationDetails(
        appName,
        notificationTitle,
        icon: notificationIconName,
        ongoing: true,
      ),
    ),
  );
  await Future.delayed(const Duration(seconds: 30));
  getLocation(flutterLocalNotificationsPlugin);
}

Future<bool> isLocationServiceRunning() async {
  final service = FlutterBackgroundService();
  var isRunning = await service.isRunning();
  return isRunning;
}

Future<void> stopLocationService() async {
  if (await isLocationServiceRunning()) {
    FlutterBackgroundService().invoke("stopService");
  }
}

Future<void> startLocationService() async {
  if (!await isLocationServiceRunning()) {
    var service = FlutterBackgroundService();
    service.invoke("setAsForeground");
    service.startService();
  }
}
