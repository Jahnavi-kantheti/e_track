import 'package:e_track/screens/add_employee/add_employee_controller.dart';
import 'package:e_track/screens/common/dropdown_view.dart';
import 'package:e_track/screens/common/edittext.dart';
import 'package:e_track/utils/colors.dart';
import 'package:e_track/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../common/mybutton.dart';

class AddEmployeeScreen extends StatefulWidget {
  final String? shareUserId;

  const AddEmployeeScreen({super.key, this.shareUserId});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final controller = Get.put(AddEmployeeController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.fetchCountries();
      if (widget.shareUserId.isNotNullOrEmpty) {
        controller.getEmployeeDetails(widget.shareUserId!);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.shareUserId.isNotNullOrEmpty ? "Update Employee" : "Add Employee",
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: colorBlack),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () async {
                  Get.dialog(Center(
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                          color: colorWhite,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () async {
                                final XFile? photo = await ImagePicker()
                                    .pickImage(source: ImageSource.camera);
                                Get.back();
                                if(photo?.path == null) return;
                                controller.profilePic.value = photo;
                              },
                              child: Text('Camera')),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 2,
                              height: 20,
                              color: colorPrimaryDark,
                            ),
                          ),
                          TextButton(
                              onPressed: () async {
                                final XFile? photo = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                Get.back();
                                if(photo?.path == null) return;
                                controller.profilePic.value = photo;
                              },
                              child: Text('Gallery')),
                        ],
                      ),
                    ),
                  ));
                },
                child: CircleAvatar(
                  backgroundColor: colorPrimary,
                  radius: 38.0,
                  child: Obx(
                    () => CircleAvatar(
                      backgroundImage: controller.getProfileImage(),
                      radius: 36.0,
                    ),
                  ),
                ),
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
                keyboardType: TextInputType.emailAddress,
                controller: controller.emailController,
                mandatory: true,
              ),
              const SizedBox(
                height: 10,
              ),
              EditText(
                label: "Mobile No.",
                controller: controller.phoneController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                mandatory: true,
                maxLength: 10,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
              ),
              const SizedBox(
                height: 5,
              ),
              Obx(
                () => DropdownView(
                  mandatory: true,
                  label: "Country",
                  selectedValue: controller.selectedCountry.value,
                  items: controller.countries.value,
                  onChange: (String data) {
                    controller.selectedCountry.value = data;
                    controller.fetchStates();
                  },
                ),
              ),
              Obx(
                () => DropdownView(
                  mandatory: true,
                  label: "State",
                  selectedValue: controller.selectedState.value,
                  items: controller.states.value,
                  onChange: (String data) {
                    controller.selectedState.value = data;
                    if (controller.selectedState.value == '-1') {
                      controller.districts.value = [defaultDropdown()];
                      controller.selectedDistrict.value = '-1';
                    } else {
                      controller.fetchDistricts();
                    }
                  },
                ),
              ),
              Obx(
                () => DropdownView(
                  mandatory: true,
                  label: "District",
                  selectedValue: controller.selectedDistrict.value,
                  items: controller.districts.value,
                  onChange: (String data) {
                    controller.selectedDistrict.value = data;
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              EditText(
                label: "Address",
                maxLines: 3,
                controller: controller.addressController,
                mandatory: true,
              ),
              const SizedBox(
                height: 10,
              ),
              EditText(
                label: "PIN code",
                controller: controller.zipCodeController,
                mandatory: true,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                maxLength: 6,
              ),
              const SizedBox(
                height: 10,
              ),
              EditText(
                label: "Aadhaar no.",
                controller: controller.aadhaarController,
                mandatory: true,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                maxLength: 12,
              ),
              const SizedBox(
                height: 10,
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
