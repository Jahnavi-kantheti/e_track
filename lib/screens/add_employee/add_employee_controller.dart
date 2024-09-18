import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:e_track/screens/common/loader.dart';
import 'package:e_track/utils/global.dart';
import 'package:e_track/utils/storagebox.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

import '../../models/employee.dart';
import '../../network/api_service.dart';
import '../../utils/colors.dart';
import '../../utils/strings.dart';

class AddEmployeeController extends GetxController {
  
  final zipCodeController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final aadhaarController = TextEditingController();
  final countries = RxList<DropdownMenuItem<dynamic>>([defaultDropdown()]);
  final selectedCountry = "-1".obs;

  final states = RxList<DropdownMenuItem<dynamic>>([defaultDropdown()]);
  final selectedState = '-1'.obs;

  final districts = RxList<DropdownMenuItem<dynamic>>([defaultDropdown()]);
  final selectedDistrict = '-1'.obs;

  final selectedEmployee = Rx<Employee?>(null);

  final profilePic = Rx<XFile?>(null);

  Future<void> saveEmployee() async {
    final isValid = validateForm();
    if (!isValid) {
      return;
    }

    showLoader();
    try {
      final response = await ApiService.instance.request(
        'etrack/create_my_employee',
        DioMethod.post,
        formData: {
          'user_id': StorageBox.instance.getUserId(),
          'user_type': "Employee",
          'first_name': firstNameController.text,
          'last_name': lastNameController.text,
          'mobile': phoneController.text,
          'email': emailController.text,
          'address': addressController.text,
          'country_id': selectedCountry.value,
          'state_id': selectedState.value,
          'district_id': selectedDistrict.value,
          'city_id': '1',
          'zipcode': zipCodeController.text,
          'aadhar_number': aadhaarController.text,
          'device_token': StorageBox.instance.getDeviceID(),
          if (profilePic.value != null)
            'profile_image': dio.MultipartFile.fromFile(profilePic.value!.path,
                filename: profilePic.value!.name,
                contentType: MediaType.parse(profilePic.value!.mimeType!))
        },
        contentType: 'application/json',
      );
      dismissLoader();
      if (response.statusCode == 200) {
        if (response.data['status'] == true) {
          Get.back(result: true);
          showToast(message: "Employee successfully created");
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

  bool validateForm() {
    if (firstNameController.text.isBlank == true) {
      showToast(message: "Please provide First Name");
      return false;
    }
    if (lastNameController.text.isBlank == true) {
      showToast(message: "Please provide Last Name");
      return false;
    }
    if (emailController.text.isBlank == true) {
      showToast(message: "Please provide Email");
      return false;
    }
    if (!EmailValidator.validate(emailController.text)) {
      showToast(message: "Please provide Valid Email");
      return false;
    }
    if (phoneController.text.isBlank == true ||
        phoneController.text.length > 10 ||
        phoneController.text.length < 10) {
      showToast(message: "Please provide valid Mobile No.");
      return false;
    }
    if (selectedCountry.value == '-1') {
      showToast(message: "Please provide Country");
      return false;
    }
    if (selectedState.value == '-1') {
      showToast(message: "Please provide State");
      return false;
    }
    if (selectedDistrict.value == '-1') {
      showToast(message: "Please provide District");
      return false;
    }
    if (addressController.text.isBlank == true) {
      showToast(message: "Please provide Address");
      return false;
    }
    if (aadhaarController.text.isBlank == true) {
      showToast(message: "Please provide Password");
      return false;
    }
    if (zipCodeController.text.isBlank == true) {
      showToast(message: "Please provide PIN code");
      return false;
    }
    return true;
  }

  fetchCountries() async {
    try {
      showLoader();
      final response = await ApiService.instance.request(
        'user/country_list',
        DioMethod.get,
        contentType: 'application/json',
      );
      dismissLoader();
      if (response.statusCode == 200) {
        if (response.data['status'] == true) {
          List<DropdownMenuItem> apiCountries = [defaultDropdown()];
          apiCountries.addAll(response.data['data']
              .map<DropdownMenuItem>((e) => DropdownMenuItem(
                    value: e['country_id'],
                    child: Text(e['country'],
                        style: TextStyle(fontSize: 14, color: colorBlack)),
                  ))
              .toList());
          countries.value = apiCountries;
          if (countries.where((e) => e.value == '99').isNotEmpty) {
            selectedCountry.value = '99';
            await fetchStates();
          }
        } else {
          showToast(message: response.data['message']);
        }
      } else {
        showToast(message: response.statusMessage ?? networkErrorMsg);
      }
    } catch (e) {
      showToast(message: e.toString());
      dismissLoader();
    }
  }

  fetchStates({bool isForBinding = false}) async {
    selectedState.value = '-1';
    selectedDistrict.value = '-1';
    try {
      showLoader();
      final response = await ApiService.instance.request(
        'user/state_list',
        DioMethod.get,
        param: {'country_id': selectedCountry.value},
        contentType: 'application/json',
      );
      dismissLoader();
      if (response.statusCode == 200) {
        if (response.data['status'] == true) {
          List<DropdownMenuItem> apiStates = [defaultDropdown()];
          apiStates.addAll(response.data['data']
              .map<DropdownMenuItem>((e) => DropdownMenuItem(
                    value: e['state_id'],
                    child: Text(e['state'],
                        style:
                            const TextStyle(fontSize: 14, color: colorBlack)),
                  ))
              .toList());
          states.value = apiStates;
          districts.value = [defaultDropdown()];
          if (isForBinding &&
              selectedEmployee.value?.stateId?.isNotNullOrEmpty == true) {
            if (states
                .where((e) => e.value == selectedEmployee.value!.stateId!)
                .isNotEmpty) {
              selectedState.value = selectedEmployee.value!.stateId!;
              fetchDistricts(isForBinding: isForBinding);
            }
          }
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

  fetchDistricts({bool isForBinding = false}) async {
    selectedDistrict.value = '-1';
    try {
      showLoader();
      final response = await ApiService.instance.request(
        'user/district_list',
        DioMethod.get,
        param: {'state_id': selectedState.value},
        contentType: 'application/json',
      );
      dismissLoader();
      if (response.statusCode == 200) {
        if (response.data['status'] == true) {
          List<DropdownMenuItem> apiStates = [defaultDropdown()];
          apiStates.addAll(response.data['data']
              .map<DropdownMenuItem>((e) => DropdownMenuItem(
                    value: e['district_id'],
                    child: Text(e['district'],
                        style:
                            const TextStyle(fontSize: 14, color: colorBlack)),
                  ))
              .toList());
          districts.value = apiStates;
          if (isForBinding &&
              selectedEmployee.value?.districtId?.isNotNullOrEmpty == true) {
            if (districts
                .where((e) => e.value == selectedEmployee.value!.districtId!)
                .isNotEmpty) {
              selectedDistrict.value = selectedEmployee.value!.districtId!;
            }
          }
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

  getEmployeeDetails(String shareUserId) async {
    showLoader();
    try {
      final response = await ApiService.instance.request(
        'etrack/employee_detail',
        DioMethod.post,
        formData: {
          'user_id': StorageBox.instance.getUserId(),
          'share_user_id': shareUserId,
          'user_type': 'Customer',
          'device_token': StorageBox.instance.getDeviceID(),
        },
        contentType: 'application/json',
      );
      dismissLoader();
      if (response.statusCode == 200) {
        if (response.data['status'] == true) {
          final List<Employee> employees = response.data['data']
              .map<Employee>((e) => Employee.fromJson(e))
              .toList();
          if (employees.isNotEmpty) {
            Employee employee = employees[0];
            selectedEmployee.value = employee;
            bindEmployee(employee);
          }
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

  ImageProvider getProfileImage() {
    if (selectedEmployee.value?.profileImage?.isNotNullOrEmpty == true &&
        !selectedEmployee.value!.profileImage!
            .contains("uploads/no-image.png")) {
      return NetworkImage(selectedEmployee.value!.profileImage!);
    } else if (profilePic.value != null) {
      return FileImage(File(profilePic.value!.path));
    } else {
      return const AssetImage("assets/images/icons/user.png");
    }
  }

  void bindEmployee(Employee employee) {
    firstNameController.text = employee.firstName ?? '';
    lastNameController.text = employee.lastName ?? '';
    emailController.text = employee.email ?? '';
    phoneController.text = employee.mobile ?? '';
    addressController.text = employee.address ?? '';
    zipCodeController.text = employee.pincode ?? '';
    aadhaarController.text = employee.aadharNumber ?? '';
    selectedCountry.value = employee.countryId ?? '99';
    fetchStates(isForBinding: true);
  }
}
