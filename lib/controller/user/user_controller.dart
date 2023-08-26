// ignore_for_file: avoid_print

import 'package:employee_parking/controller/user/api_user.dart';
import 'package:employee_parking/model/reservation_model.dart';
import 'package:employee_parking/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../helper/constant.dart';

class UserController extends GetxController {
  var reservation = <ReservationModel>[].obs;
  var activeUser = <UserModel>[].obs;
  @override
  void onInit() {
    fetchReservation();
    fetchActiveUser();
  }
  Future<void> userEntry(String id, String carID) async {
    try {
      await ApiUser.userEnteryGarage(id, carID);
      EasyLoading.showSuccess('Entry has been made',
          maskType: EasyLoadingMaskType.black,
          duration: const Duration(milliseconds: 500));
    } catch (e) {
      print("$e");
    }
  }

  Future<void> userExite(String id, String carID) async {
    try {
      print(id);
      print(carID);
      await ApiUser.userExiteGarage(id, carID);
      EasyLoading.showSuccess('Directed by',
          maskType: EasyLoadingMaskType.black,
          duration: const Duration(milliseconds: 500));
    } catch (e) {
      print("$e");
    }
  }

  Future<void> fetchReservation() async {
    try {
      final fetchData = await ApiUser.fetchReserv();
      reservation.assignAll(fetchData);
      // print(reservation.length);
    } catch (e) {
      print("$e");
    }
  }

  Future<void> fetchActiveUser() async {
    try {
      final fetchData = await ApiUser.fetchActiveUsers();
      activeUser.assignAll(fetchData);
      print(activeUser.length);
    } catch (e) {
      print(e.toString());
    }
  }
  static final Rx<DateTime> _dateTimeStart = DateTime.now().obs;
  set dateTimeStart(DateTime value) => _dateTimeStart.value = value;
  DateTime get dateTimeStart => _dateTimeStart.value;
  Future<void> updateTime1() async {
    TimeOfDay? newTime = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.fromDateTime(_dateTimeStart.value),
    );
    if (newTime == null) return;
    dateTimeStart = DateTime(
      dateTimeStart.year,
      dateTimeStart.month,
      dateTimeStart.day,
      newTime.hour,
      newTime.minute,
    );
    update();
  }

  static final Rx<DateTime> _dateTimeEnd = DateTime.now().obs;
  set dateTimeEnd(DateTime value) => _dateTimeEnd.value = value;
  DateTime get dateTimeEnd => _dateTimeEnd.value;
  Future<void> updateTimeEnd() async {
    TimeOfDay? newTime = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.fromDateTime(_dateTimeEnd.value),
    );
    if (newTime == null) return;
    dateTimeEnd = DateTime(
      dateTimeEnd.year,
      dateTimeEnd.month,
      dateTimeEnd.day,
      newTime.hour,
      newTime.minute,
    );
    update();
  }
  DateTime dateTime = DateTime.now();
  void showBookUser(int userId,int carId,int parkingID,int floorID) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 170),
          child: AlertDialog(
            icon: const Icon(Icons.collections_bookmark_outlined, size: 50),
            title: const Text('Book For a User'),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    updateTime1();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkblue,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text(
                    'Start Time',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                      () => Text(
                    "Start Hour -> ${dateTimeStart.hour} : ${dateTimeStart.minute}",
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    updateTimeEnd();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkblue,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    'End Time',
                    style: TextStyle(color: lightgreen, fontSize: 18),
                  ),
                ), const SizedBox(height: 10),
                Obx(
                      () => Text(
                    "End Hour -> ${dateTimeEnd.hour} : ${dateTimeEnd.minute}",
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  addBook(userId,carId,parkingID,floorID);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> addBook(int customerID,int carId ,int parkingID,int floorID) async{
    String formattedDateStart = DateFormat('HH:mm').format(dateTimeStart).padLeft(2, '0');
    String formattedDateEnd = DateFormat('HH:mm').format(dateTimeEnd).padLeft(2, '0');
    String formattedDate = DateFormat('y-MM-dd').format(dateTime);
    try{
      await ApiUser.addBookUser(customerID,carId,parkingID,floorID,formattedDateStart,formattedDateEnd,formattedDate);
      EasyLoading.showSuccess('Successfully booked',
          maskType: EasyLoadingMaskType.black,
          duration: const Duration(milliseconds: 500));
      Get.back();
    }catch(e){
      print(e.toString());
    }
  }

  Future<void> payment(String id) async{
    try{
      await ApiUser.makePayment(id);
      EasyLoading.showSuccess('Successfully booked',
          maskType: EasyLoadingMaskType.black,
          duration: const Duration(milliseconds: 500));
    }catch(e){
      print(e.toString());
    }
  }
}
