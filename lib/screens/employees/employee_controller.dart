import 'package:e_track/models/employee.dart';
import 'package:e_track/network/api_service.dart';
import 'package:e_track/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/debounce.dart';
import '../../utils/storagebox.dart';
import '../../utils/strings.dart';
import '../common/loader.dart';

class EmployeeController extends GetxController {
  
  final TextEditingController searchTextController = TextEditingController();
  final dateUsers = RxList<Employee>([]);
  final searchEnable = false.obs;
  final apiData = <Employee>[];
  final Debounce _debounce = Debounce(const Duration(milliseconds: 400));

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    searchTextController.dispose();
    _debounce.dispose();
    super.onClose();
  }

  void onChangeListener() {
    _debounce(() {
      if (searchTextController.text.isEmpty) {
        dateUsers.value = apiData;
      } else {
        final data = apiData
            .where((d) =>
                (d.email ?? '').toLowerCase().contains(searchTextController.text.toLowerCase()) ||
                (d.firstName ?? '').toLowerCase().contains(searchTextController.text.toLowerCase()))
            .toList();
        dateUsers.value = data;
      }
    });
  }

  Future<void> fetchUsers() async {
    try {
      showLoader();
      final response = await ApiService.instance
          .request('etrack/my_employees_list', DioMethod.get, param: {
        'user_id': StorageBox.instance.getUserId(),
        'device_token': StorageBox.instance.getDeviceID(),
        'user_type': StorageBox.instance.isAdmin() ? "Customer" : "Employee",
      });
      if (response.statusCode == 200) {
        if (response.data['status'] == true) {
          final List<Employee> employees = response.data['data']
              .map<Employee>((e) => Employee.fromJson(e))
              .toList();
          dismissLoader();
          dateUsers.value = employees;
          apiData.clear();
          apiData.addAll(employees);

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
