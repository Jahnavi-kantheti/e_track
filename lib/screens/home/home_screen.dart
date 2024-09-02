import 'package:e_track/screens/common/mybutton.dart';
import 'package:e_track/screens/home/homecontroller.dart';
import 'package:e_track/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/location_service.dart';
import '../../utils/storagebox.dart';
import '../common/app_drawer.dart';
import '../common/swipesview.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorWhite,
        appBar: AppBar(
          elevation: 0,
          leading: Builder(builder: (context) {
            return Center(
              child: GestureDetector(
                onTap: () {
                  controller.checkSync();
                  Scaffold.of(context).openDrawer();
                },
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Icon(
                    Icons.menu,
                    size: 24,
                    color: colorWhite,
                  ),
                ),
              ),
            );
          }),
          title: const Text(
            "Home",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: colorBlack),
          ),
        ),
        drawer: AppDrawer(controller: controller),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 10),
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi ${StorageBox.instance.getUserName().split(" ")[0]} 👋',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: colorPrimaryDark),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 10,
                        surfaceTintColor: colorWhite,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(children: [
                            CircleAvatar(
                              radius: 60,
                              child: Obx(
                                () => Text(
                                  controller
                                      .getDateValue()
                                      .time
                                      .replaceAll("", " "),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: colorPrimaryDark,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  controller.getDateValue().day,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: colorPrimaryDark,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  controller.getDateValue().date,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: colorPrimaryDark,
                                      fontWeight: FontWeight.w300),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                MyButton(
                                    label: "Sign In",
                                    onPress: () {
                                      retrieveLatLng();
                                    })
                              ],
                            )
                          ]),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    swipesView(inTime: '10:00', outTime: '07:30'),
                  ],
                )))));
  }
}
