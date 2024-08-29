import 'package:e_track/screens/common/edittext.dart';
import 'package:e_track/screens/common/mybutton.dart';
import 'package:e_track/screens/login/authcontroller.dart';
import 'package:e_track/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/strings.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimaryDark,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: Get.height * 0.1),
        child: SingleChildScrollView(
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 10,
            surfaceTintColor: colorWhite,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    appName.replaceAll('', ' '),
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: colorBlack),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Hello there! 👋',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: colorPrimaryDark),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  EditText(
                    label: 'Email',
                    controller: controller.emailTextController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  EditText(
                    label: 'Password',
                    controller: controller.passwordTextController,
                    isPassword: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: false,
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Forgot password?",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.end,
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyButton(
                    label: "Login",
                    onPress: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      controller.doLogin();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
