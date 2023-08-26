// ignore_for_file: avoid_print

import 'package:get/get.dart';

import '../../model/garage_model.dart';
import 'api_services.dart';

class SubscriptionController extends GetxController {
  var subUser = GarageModel(name: '', id: 0, price_per_hour: 0.0, time_open: '', time_close: '').obs;
  @override
  void onInit() {
    getSubUser();
  }
  Future<void> getSubUser() async {
    try {
      final fetchSubUser =
          await ApiServices.getSubUser1();
      subUser.value = fetchSubUser;
      update();
    } catch (e) {
      print("failed fetch user subscription : $e");
    }
  }
}
