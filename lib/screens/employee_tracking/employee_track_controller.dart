
import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../common/loader.dart';

class EmployeeTrackController extends GetxController {
  final Rx<DateTime> date = Rx<DateTime>(DateTime.now());
  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();
  final CameraPosition googlePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

}