import 'package:employee_parking/model/garage_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/constant.dart';

class GarageController extends GetxController {
  RxInt selectedIndexButtons = 0.obs;
  RxInt selectedIndexText = 0.obs;
  RxInt floor = 1.obs;

  void changeColor(int index) {
    selectedIndexButtons.value = index;
    selectedIndexText.value = index;
    update();
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

  var garage = <GarageModel>[].obs;
}
