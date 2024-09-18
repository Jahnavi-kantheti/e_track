import 'package:e_track/screens/change_password/change_password_controller.dart';
import 'package:e_track/screens/common/edittext.dart';
import 'package:e_track/screens/common/mybutton.dart';
import 'package:e_track/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  final controller = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        title: const Text(
          "Change Password",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: colorBlack),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              EditText(
                label: "Current password",
                controller: controller.currentPasswordController,
                isPassword: true,
                mandatory: true,
              ),
              const SizedBox(
                height: 10,
              ),
              EditText(
                label: "New password",
                controller: controller.newPasswordController,
                isPassword: true,
                mandatory: true,
              ),
              const SizedBox(
                height: 10,
              ),
              EditText(
                label: "Confirm password",
                controller: controller.confirmPasswordController,
                isPassword: true,
                mandatory: true,
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        child: MyButton(
            label: "Save",
            onPress: () {
              controller.updatePassword();
            }),
      ),
    );
  }
}
