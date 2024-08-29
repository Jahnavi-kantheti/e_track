import 'package:e_track/utils/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddEmployeeController extends GetxController {
  final empIdController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final showPassword = false.obs;

  void saveEmployee() {
    final isValid = validateForm();
    if(!isValid){
      return;
    }

  }

  bool validateForm() {
    if (empIdController.text.isBlank == true) {
      showToast(message: "Please provide Employee Id");
      return false;
    }
    if (firstNameController.text.isBlank == true) {
      showToast(message: "Please provide First Name");
      return false;
    }
    if (lastNameController.text.isBlank == true) {
      showToast(message: "Please provide Last Name");
      return false;
    }
    if (emailController.text.isBlank == true) {
      showToast(message: "Please provide Email");
      return false;
    }
    if (phoneController.text.isBlank == true) {
      showToast(message: "Please provide Mobile No.");
      return false;
    }
    if (addressController.text.isBlank == true) {
      showToast(message: "Please provide Address");
      return false;
    }
    if (passwordController.text.isBlank == true) {
      showToast(message: "Please provide Password");
      return false;
    }
    return true;
  }
}
