import 'package:e_track/models/internal/date.dart';
import 'package:e_track/utils/global.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../utils/location_service.dart';

class HomeController extends GetxController {
  final Rx<Date> _date = Rx<Date>(Date());
  final Rx<PackageInfo> _info = Rx<PackageInfo>(PackageInfo(
      appName: '',
      packageName: '',
      version: '',
      buildNumber: '',
      buildSignature: '',
      installerStore: ''));
  final isSyncing = false.obs;

  @override
  void onInit() {
    callDate();
    _initPackageInfo();
    super.onInit();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    _info.value = info;
  }

  void callDate() {
    final date = getDate();
    _date.value = date;
    Future.delayed(const Duration(seconds: 1), () {
      callDate();
    });
  }

  Date getDateValue() => _date.value;

  PackageInfo getInfoValue() => _info.value;


  Future<void> checkSync() async {
    bool sync = await isLocationServiceRunning();
    isSyncing.value = sync;
  }
}
