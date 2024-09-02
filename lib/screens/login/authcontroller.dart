import 'package:e_track/screens/employees/employees_screen.dart';
import 'package:e_track/utils/storagebox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../network/api_service.dart';
import '../../utils/global.dart';
import '../../utils/strings.dart';
import '../home/home_screen.dart';

class AuthController extends GetxController {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  void doLogin() async {
    final email = emailTextController.text;
    final password = emailTextController.text;
    try {
      final response = await ApiService.instance.request(
        '/api/endpoint',
        DioMethod.post,
        param: {'email': email, 'password': password},
        contentType: 'application/json',
      );
      if (response.statusCode == 200) {
        print('API call successful: ${response.data}');
        StorageBox.instance.setToken("value");
        StorageBox.instance.setIsAdmin(email == "admin");
      } else {
        StorageBox.instance.setToken("123");
        StorageBox.instance.setIsAdmin(email == "admin");
        print('API call failed: ${response.statusMessage}');
        showToast(message: response.statusMessage ?? networkErrorMsg);
      }
    } catch (e) {
      StorageBox.instance.setToken("123");
      StorageBox.instance.setIsAdmin(email == "admin");
      print('Network error occurred: $e');
      showToast(message: e.toString());
      StorageBox.instance.setUserName("Prudhvi Sai");
      Get.off(() => HomeScreen());
      Get.delete<AuthController>();
    }
  }
}
