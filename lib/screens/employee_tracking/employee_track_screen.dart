import 'package:e_track/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../common/swipesview.dart';
import 'employee_track_controller.dart';

class EmployeeTrackScreen extends StatefulWidget {
  const EmployeeTrackScreen({super.key});

  @override
  State<EmployeeTrackScreen> createState() => _EmployeeTrackScreenState();
}

class _EmployeeTrackScreenState extends State<EmployeeTrackScreen> {
  final controller = Get.put(EmployeeTrackController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Track Details",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                const Text(
                  "Select Date:",
                  style:
                      TextStyle(fontWeight: FontWeight.w600, color: colorBlack),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                      ()=> Text(
                          DateFormat("dd-MMM-yyyy").format(controller.date.value),
                          style: const TextStyle(color: colorBlack),
                        ),
                      ),
                      SizedBox(width: 8,),
                      const Icon(Icons.calendar_month)
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),

            SizedBox(height: 10,),
            Container(
              width: double.infinity,
              height: 300,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GoogleMap(initialCameraPosition: controller.googlePlex)),
            ),
            const SizedBox(
              height: 20,
            ),
            swipesView(inTime: '10:00', outTime: '07:30'),
          ],
        )),
      )),
      backgroundColor: colorWhite,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: controller.date.value,
        firstDate: DateTime(2024, 1),
        lastDate: controller.date.value);
    if (picked != null && picked != controller.date.value) {
      controller.date.value = picked;
    }
  }
}
