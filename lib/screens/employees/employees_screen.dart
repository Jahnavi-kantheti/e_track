import 'package:e_track/screens/add_employee/add_employee_screen.dart';
import 'package:e_track/screens/employee_tracking/employee_track_screen.dart';
import 'package:e_track/screens/employees/employee_controller.dart';
import 'package:e_track/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_){
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
      body: SafeArea(
          child: ListView(
        children: [
          const ListTile(
            title: Text("Jahnavi Rani"),
            subtitle: Text("Jahnavi@gmail.com"),
          ),
          ListTile(
            title: const Text("Prudhvi K"),
            subtitle: const Text("pk@gmail.com"),trailing: TextButton(onPressed: (){
              Get.to(() => const EmployeeTrackScreen());
          }, child: const Text("Track")),
          )
        ],
      )),
    );
  }
}
