import 'package:e_track/models/employee.dart';
import 'package:e_track/screens/add_employee/add_employee_screen.dart';
import 'package:e_track/screens/common/edittext.dart';
import 'package:e_track/screens/employees/employee_controller.dart';
import 'package:e_track/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../add_employee/add_employee_controller.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchUsers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToCreation();
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text(
          "Employees",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: colorBlack),
        ),
        actions: [
          IconButton(
              onPressed: () {
                controller.searchEnable.toggle();
                controller.searchTextController.clear();
                controller.dateUsers.value = controller.apiData;
              },
              icon: const Icon(Icons.search))
        ],
        elevation: 0,
      ),
      body: SafeArea(
          child: Obx(
        () => Column(
          children: [
            controller.searchEnable.value
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                        elevation: 5,
                        child: EditText(
                            hint: "Type here to search",
                            onChange: (value) {
                              controller.onChangeListener();
                            },
                            label: null,
                            controller: controller.searchTextController)))
                : const SizedBox(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await controller.fetchUsers();
                },
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: controller.dateUsers.length,
                  itemBuilder: (context, index) {
                    Employee employee = controller.dateUsers[index];
                    return ListTile(
                      onTap: () {
                        navigateToCreation(shareUserId: employee.userId);
                      },
                      title: Text("${employee.firstName} ${employee.lastName}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(employee.email ?? ''),
                          Text(employee.mobile ?? ''),
                        ],
                      ),
                      trailing: TextButton(
                          onPressed: () {
                            Get.to(() => const EmployeeTrackScreen());
                          },
                          child: const Text("Track")),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  void navigateToCreation({String? shareUserId}) {
    Get.delete<AddEmployeeController>();
    Get.to(() => AddEmployeeScreen(
          shareUserId: shareUserId,
        ))?.then((value) {
      if (value != null) {
        controller.fetchUsers();
      }
      return value;
    });
  }
}
