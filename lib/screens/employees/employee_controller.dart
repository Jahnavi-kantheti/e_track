import 'dart:convert';

import 'package:e_track/models/user.dart';
import 'package:e_track/network/api_service.dart';
import 'package:e_track/utils/global.dart';
import 'package:get/get.dart';

class EmployeeController extends GetxController {
  final _users = RxList<UserResponse>([]);


  void fetchUsers() async {
    try {
      showLoader();
      final response =
          await ApiService.instance.request('/users', DioMethod.get);
      final List<UserResponse> users = response.data
          .map<UserResponse>((e) => UserResponse.fromJson(e))
          .toList();

      print(users.map((e) => e.email));
      dismissLoader();
    } catch (e) {
      dismissLoader();
      print(e);
    }
  }
}
