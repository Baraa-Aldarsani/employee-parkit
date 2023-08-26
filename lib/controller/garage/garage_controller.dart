import 'package:employee_parking/controller/control_controller.dart';
import 'package:employee_parking/model/garage_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helper/constant.dart';
import 'api_services.dart';

class GarageController extends GetxController {
  RxInt selectedQualities = RxInt(-1);
  RxInt selectedIndexButtons = 0.obs;
  RxInt selectedIndexText = 0.obs;
  RxInt floor = 1.obs;

  int get updateFloor => floor.value;
  var fetchGarage = GarageModel(
          name: '', id: 0, price_per_hour: 0.0, time_open: '', time_close: '')
      .obs;

  void changeColor(int index) {
    selectedIndexButtons.value = index;
    selectedIndexText.value = index;
    update();
  }

  @override
  void onInit() {
    getGarage();
  }

  void increase(int index) {
    floor.value = index + 1;
    update();
  }

  Color getColorButtons(int index) {
    return selectedIndexButtons.value == index ? darkblue : Colors.white;
  }

  Color getColorText(int index) {
    return selectedIndexButtons.value == index ? Colors.white : darkblue;
  }

  void changeQualities(int index) {
    selectedQualities.value = index;
    update();
  }

  Widget getStatusQualities1(int index, String parking) {
    String status = 'noSelect';
    status = selectedQualities.value == index ? 'select' : 'noSelect';
    return status == 'noSelect'
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 200,
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: darkblue),
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: lightgreen),
              alignment: Alignment.center,
              child: Text(
                parking,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 200,
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: darkblue),
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: darkblue),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    parking,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.check_box,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          );
  }

  Future<void> getGarage() async {
    try {
      final fetchedGarages = await ApiServices.getGarage();
      fetchGarage.value = fetchedGarages;
      update();
    } catch (e) {
      print(e.toString());
    }
  }


  void showAlertDialog(int floor,int parking) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 250),
        child: AlertDialog(
          icon: const Icon(Icons.select_all, size: 70),
          title: const Text('Select User OR Customer'),
          content: GetBuilder<ControlController>(
            init: ControlController(),
            builder:(controller) => Column(
              children: [
                SizedBox(
                    width: 150,
                    height: 40,
                    child: MaterialButton(
                      onPressed: () {
                        controller.changeSelectedValue(8,floor: floor,parking: parking);
                        Get.back();
                      },
                      color: deepdarkblue,
                      child: const Text(
                        "User",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                const SizedBox(height: 20),
                SizedBox(
                    width: 150,
                    height: 40,
                    child: MaterialButton(
                      onPressed: () {
                        controller.changeSelectedValue(5,floor: floor,parking: parking);
                        Get.back();
                      },
                      color: deepdarkblue,
                      child: const Text(
                        "Customer",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
