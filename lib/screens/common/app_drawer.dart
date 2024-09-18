import 'package:e_track/screens/change_password/change_password_screen.dart';
import 'package:e_track/screens/employees/employee_controller.dart';
import 'package:e_track/screens/employees/employees_screen.dart';
import 'package:e_track/screens/home/homecontroller.dart';
import 'package:e_track/utils/colors.dart';
import 'package:e_track/utils/storagebox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/global.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: Get.width * 0.5,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: colorPrimaryDark,
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: colorWhite,
                    radius: 36,
                    backgroundImage: getProfileImage(),
                  ),
                  const Spacer(),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Obx(() => Icon(
                            controller.isSyncing.value
                                ? Icons.sync
                                : Icons.sync_disabled,
                            size: 20,
                            color: colorWhite,
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        StorageBox.instance.getFullName(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: colorWhite,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const Spacer()
                ],
              ),
            ),
            ListTile(
              title: const Text(
                'Home',
                style: TextStyle(color: colorBlack, fontSize: 16),
              ),
              onTap: () {
                Get.back();
              },
            ),
            StorageBox.instance.isAdmin()
                ? ListTile(
                    title: const Text(
                      'Employees',
                      style: TextStyle(color: colorBlack, fontSize: 16),
                    ),
                    onTap: () async {
                      Get.back();
                      await Future.delayed(const Duration(milliseconds: 400),
                          () {
                        Get.delete<EmployeeController>();
                        Get.to(() => const EmployeesScreen());
                      });
                    },
                  )
                : SizedBox(),
            ListTile(
              title: const Text(
                'Change Password',
                style: TextStyle(
                  color: colorBlack,
                  fontSize: 16,
                ),
              ),
              onTap: () async {
                Get.back();
                await Future.delayed(const Duration(milliseconds: 400),
                        () {
                      Get.to(() => ChangePasswordScreen());
                    });
              },
            )
            ,
            ListTile(
              title: const Text(
                'Log out',
                style: TextStyle(
                  color: colorBlack,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                logOut();
              },
            ),
            ListTile(
              title: Text(
                "App Ver: ${controller.getInfoValue().version}",
                style: const TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 12,
                    color: colorPrimaryDark),
              ),
            ),
          ],
        ));
  }

  ImageProvider getProfileImage() {
    var profilePic = StorageBox.instance.getProfilePic();
    if (profilePic.isNotNullOrEmpty) {
      return NetworkImage(profilePic!);
    } else {
      return const AssetImage("assets/images/icons/user.png");
    }
  }
}
