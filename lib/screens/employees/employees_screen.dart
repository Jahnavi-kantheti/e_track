import 'package:e_track/models/user.dart';
import 'package:e_track/screens/add_employee/add_employee_screen.dart';
import 'package:e_track/screens/employees/employee_controller.dart';
import 'package:e_track/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../employee_tracking/employee_track_screen.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  final controller = Get.put(EmployeeController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddEmployeeScreen())?.then((value) {
            controller.fetchUsers();
            return value;
          });
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text(
          "Employees",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: colorBlack),
        ),
        elevation: 0,
      ),
      body: SafeArea(child: Obx(
          ()=> ListView.builder(
            itemCount: controller.dateUsers.length,
          itemBuilder: (context, index) {
              UserResponse user = controller.dateUsers[index];
            return ListTile(
              title: Text(user.name),
              subtitle: Text(user.email),trailing: TextButton(onPressed: (){
              Get.to(() => const EmployeeTrackScreen());
            }, child: const Text("Track")),
            );
          },
        ),
      )),
    );
  }
}
