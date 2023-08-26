// ignore_for_file: invalid_use_of_protected_member
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/customer/customer_controller.dart';
import '../controller/garage/garage_controller.dart';
import '../controller/services/services_controller.dart';
import '../controller/user/user_controller.dart';
import '../helper/constant.dart';
import '../model/garage_model.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final GarageController _controller = Get.put(GarageController());
  final CustomerController _customer = Get.put(CustomerController());
  final UserController _user = Get.put(UserController());
  GarageModel? _garageModel;
  final ServicesController ser = Get.put(ServicesController());
  int floor = 1;
  int parkingValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: FutureBuilder<void>(
            future: _controller.getGarage(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Text("data");
              } else {
                int length = _controller.fetchGarage.value.floor?.length ?? 0;
                return Column(
                  children: [
                    SizedBox(
                      height: 45,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: length,
                        itemBuilder: (BuildContext context, int index) {
                          var garage = _controller.fetchGarage.value;
                          return Obx(
                            () => InkWell(
                              onTap: () {
                                _controller.selectedQualities.value = -1;
                                _controller.changeColor(index);
                                _controller.increase(index);
                                floor = garage.floor![index].number;
                              },
                              child: Container(
                                width: 122,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1.6, color: darkblue),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                  color: _controller.getColorButtons(index),
                                ),
                                child: Text(
                                  "${garage.floor![index].number} Floor",
                                  style: TextStyle(
                                    color: _controller.getColorText(index),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          width: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Expanded(
                      child: Obx(() {
                        return GridView.builder(
                            physics: const ClampingScrollPhysics(),
                            itemCount: _controller
                                .fetchGarage
                                .value
                                .floor?[_controller.updateFloor - 1]
                                .parking!
                                .length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 70,
                                    mainAxisSpacing: 33,
                                    childAspectRatio: 1.6),
                            itemBuilder: (BuildContext context, int index) {
                              final parking = _controller
                                  .fetchGarage
                                  .value
                                  .floor?[_controller.updateFloor - 1]
                                  .parking?[index];
                              return Container(
                                decoration: ShapeDecoration(
                                  shape: index % 2 == 0
                                      ? const Border(
                                          top: BorderSide(
                                              width: 1.2, color: Colors.grey),
                                          left: BorderSide(
                                              width: 1.2, color: Colors.grey),
                                          bottom: BorderSide(
                                              width: 1.2, color: Colors.grey),
                                        )
                                      : const Border(
                                          top: BorderSide(
                                              width: 1.2, color: Colors.grey),
                                          right: BorderSide(
                                              width: 1.2, color: Colors.grey),
                                          bottom: BorderSide(
                                              width: 1.2, color: Colors.grey),
                                        ),
                                ),
                                alignment: Alignment.center,
                                child: parking?.status?.name  == 'available'
                                    ? InkWell(
                                        onTap: () {
                                          _controller.changeQualities(index);
                                          parkingValue = parking!.id;
                                        },
                                        child: Obx(() =>
                                            _controller.getStatusQualities1(
                                                index, parking?.number ?? '')),
                                      )
                                    : parking?.status?.name == 'busy'
                                        ? Image.asset(
                                            "assets/images/carWhite.jpg")
                                        : Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: 200,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 2,
                                                      color: darkblue),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(25)),
                                                  color: lightgreen),
                                              alignment: Alignment.center,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    parking?.number ?? '',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Icon(
                                                    Icons.lock,
                                                    color: deepdarkblue,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                              );
                            });
                      }),
                    ),
                  ],
                );
              }
            },
          )),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 0.1),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: lightgreen),
        padding:
            const EdgeInsets.only(left: 15, right: 15, bottom: 13, top: 10),
        child: _buildButtons(),
      ),
    );
  }

  Widget _buildButtons() {
    return _buildMaterialButton(
        label: 'Parking works',
        backgroundColor: deepdarkblue,
        textColor: lightgreen,
        onPressed: () {
          if (_controller.selectedQualities.value == -1) {
          } else {
            _controller.showAlertDialog(floor,parkingValue);
          }
        });
  }

  Widget _buildMaterialButton({
    required String label,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return MaterialButton(
      height: 60,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(color: backgroundColor),
      ),
      color: backgroundColor,
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
