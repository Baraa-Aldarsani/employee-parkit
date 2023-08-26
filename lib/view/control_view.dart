import 'package:employee_parking/controller/auth/login_controller.dart';
import 'package:employee_parking/controller/garage/garage_controller.dart';
import 'package:employee_parking/view/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/control_controller.dart';
import '../controller/employee/user_controller.dart';
import '../helper/constant.dart';

class ControlView extends StatelessWidget {
  ControlView({Key? key}) : super(key: key);
  final LoginController _loginController = Get.put(LoginController());
  final EmployeeController user = Get.put(EmployeeController());
  final GarageController garage = Get.put(GarageController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControlController>(
        init: ControlController(),
        builder: (controller) {
          return Scaffold(
            key: controller.openDrawer,
            drawer: Drawer(
              elevation: 0,
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 80,
                      color: lightgreen,
                      margin: const EdgeInsets.only(top: 15, left: 20),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/setting.png",
                            scale: 0.7,
                          ),
                          const SizedBox(width: 20),
                         Text(
                              "Parkit ${garage.fetchGarage.value.name}",
                              style: TextStyle(
                                fontFamily: 'Billabong',
                                color: deepdarkblue,
                                fontSize: 40,
                                fontWeight: FontWeight.w500,
                                height: 2,
                              ),
                            ),

                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Open  :  ${garage.fetchGarage.value.time_open}",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: deepdarkblue),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Close :  ${garage.fetchGarage.value.time_close}",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: deepdarkblue),
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        user.user.value.name,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: deepdarkblue),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 5),
                      child: Text(user.user.value.email,
                          style: TextStyle(fontSize: 16, color: darkblue)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 2),
                      child: Text("${user.user.value.phone_number}",
                          style:
                              const TextStyle(fontSize: 18, color: Colors.grey)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 2),
                      child: Text(user.user.value.address,
                          style:
                              const TextStyle(fontSize: 18, color: Colors.grey)),
                    ),
                    const Divider(),
                    InkWell(
                      onTap: () {
                        controller.changeSelectedValue(0);
                        controller.openDrawer.currentState!.closeDrawer();
                      },
                      child: ListTile(
                        title: const Text(
                          "Home",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Text("Floor & qualities"),
                        leading: Icon(Icons.home, size: 35, color: darkblue),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.changeSelectedValue(1);
                        controller.openDrawer.currentState!.closeDrawer();
                      },
                      child: ListTile(
                        title: const Text(
                          "Scan Camera",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        leading: Icon(Icons.document_scanner_outlined,
                            size: 35, color: darkblue),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.changeSelectedValue(2);
                        controller.openDrawer.currentState!.closeDrawer();
                      },
                      child: ListTile(
                        title: const Text(
                          "Add Customer",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        leading:
                            Icon(Icons.person_add, size: 35, color: darkblue),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.changeSelectedValue(3);
                        controller.openDrawer.currentState!.closeDrawer();
                      },
                      child: ListTile(
                        title: const Text(
                          "Service for a user",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        leading: Icon(Icons.design_services,
                            size: 35, color: darkblue),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.changeSelectedValue(4);
                        controller.openDrawer.currentState!.closeDrawer();
                      },
                      child: ListTile(
                        title: const Text(
                          "Customer subscription",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        leading:
                            Icon(Icons.subscriptions, size: 35, color: darkblue),
                      ),
                    ),
                    const Divider(),
                    InkWell(
                      onTap: () {
                        controller.changeSelectedValue(5);
                        controller.openDrawer.currentState!.closeDrawer();
                      },
                      child: const ListTile(
                        title: Text(
                          "All customers",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        leading: Icon(Icons.group_sharp,
                            size: 35, color: Colors.black54),
                      ),
                    ),
                    const Divider(),
                    InkWell(
                      onTap: () {
                        controller.changeSelectedValue(8);
                        controller.openDrawer.currentState!.closeDrawer();
                      },
                      child: const ListTile(
                        title: Text(
                          "All User",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        leading: Icon(Icons.people,
                            size: 35, color: Colors.black54),
                      ),
                    ),
                    const Divider(),
                    InkWell(
                      onTap: () {
                        controller.changeSelectedValue(7);
                        controller.openDrawer.currentState!.closeDrawer();
                      },
                      child: const ListTile(
                        title: Text(
                          "Settings",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        leading:
                            Icon(Icons.settings, size: 35, color: Colors.black54),
                      ),
                    ),

                    const Divider(),
                    InkWell(
                      onTap: () {
                        Get.to(Login());
                        _loginController.deleteUser();
                        _loginController.deleteID();
                        controller.openDrawer.currentState!.closeDrawer();
                      },
                      child: ListTile(
                        title: Text(
                          "Log out",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: red),
                        ),
                        leading: Icon(Icons.logout, size: 35, color: red),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            appBar: AppBar(
              backgroundColor: lightgreen,
              elevation: 0,
              title: Text(
                "Parkit",
                style: TextStyle(
                  fontFamily: 'Billabong',
                  color: deepdarkblue,
                  fontSize: 50,
                  fontWeight: FontWeight.w500,
                  height: 2,
                ),
              ),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  controller.openDrawer.currentState?.openDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  color: deepdarkblue,
                  size: 40,
                ),
              ),
            ),
            body: controller.currentScreen,
          );
        });
  }
}
