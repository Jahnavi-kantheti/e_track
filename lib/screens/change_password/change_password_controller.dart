import 'package:e_track/utils/encryption.dart';
import 'package:e_track/utils/storagebox.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../network/api_service.dart';
import '../../utils/global.dart';
import '../../utils/strings.dart';
import '../common/loader.dart';

class ChangePasswordController extends GetxController {
  
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> updatePassword() async {
    if (currentPasswordController.text.isBlank == true) {
      showToast(message: "Please provide Current password");
      return;
    }
    if (newPasswordController.text.isBlank == true) {
      showToast(message: "Please provide New password");
      return;
    }
    if (confirmPasswordController.text.isBlank == true) {
      showToast(message: "Please provide Confirm password");
      return;
    }
    if (newPasswordController.text != confirmPasswordController.text) {
      showToast(message: "New password and Confirm password doesn't match");
      return;
    }
    showLoader();
    try {
      final response = await ApiService.instance.request(
        '/user/secure_change_password',
        DioMethod.post,
        formData: {
          'old_password': aesEncrypt(currentPasswordController.text),
          'new_password': aesEncrypt(confirmPasswordController.text),
          'user_id': StorageBox.instance.getUserId(),
          'device_token': StorageBox.instance.getDeviceID()
        },
        contentType: 'application/json',
      );
      dismissLoader();
      if (response.statusCode == 200) {
        if (response.data['status'] == true) {
          showToast(message: response.data['message']);
          Get.back();
          Get.delete<ChangePasswordController>();
        } else {
          showToast(message: response.data['message']);
        }
      } else {
        showToast(message: response.statusMessage ?? networkErrorMsg);
      }
    } catch (e) {
      dismissLoader();
      showToast(message: e.toString());
    }
  }
}
