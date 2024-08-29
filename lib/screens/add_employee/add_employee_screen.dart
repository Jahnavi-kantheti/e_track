import 'package:e_track/screens/add_employee/add_employee_controller.dart';
import 'package:e_track/screens/common/edittext.dart';
import 'package:e_track/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/mybutton.dart';

class AddEmployeeScreen extends StatelessWidget {
  AddEmployeeScreen({super.key});

  final controller = Get.put(AddEmployeeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Employee",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: colorBlack),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              EditText(
                label: "Employee Id",
                controller: controller.empIdController,
                mandatory: true,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: EditText(
                      label: "First Name",
                      controller: controller.firstNameController,
                      mandatory: true,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: EditText(
                      label: "Last Name",
                      controller: controller.lastNameController,
                      mandatory: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              EditText(
                label: "Email",
                controller: controller.emailController,
                mandatory: true,
              ),
              const SizedBox(
                height: 10,
              ),
              EditText(
                label: "Mobile No.",
                controller: controller.phoneController,
                mandatory: true,
              ),
              const SizedBox(
                height: 10,
              ),
              EditText(
                label: "Address",
                maxLines: 3,
                controller: controller.addressController,
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => EditText(
                  label: "Password",
                  controller: controller.passwordController,
                  isPassword: !controller.showPassword.value,
                  mandatory: true,
                ),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      controller.showPassword.toggle();
                    },
                    child: Obx(
                      () => Text(
                        controller.showPassword.value
                            ? "Hide password"
                            : "Show password",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    )),
              ),
            ],
          ),
        ),
      )),
      backgroundColor: colorWhite,
      bottomNavigationBar: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        child: MyButton(
            label: "Save",
            onPress: () {
              controller.saveEmployee();
            }),
      ),
    );
  }
}
