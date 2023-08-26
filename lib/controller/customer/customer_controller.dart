import 'package:employee_parking/model/customer_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../helper/constant.dart';
import 'api_customer.dart';

class CustomerController extends GetxController{
  TextEditingController nameCustomer = TextEditingController();
  TextEditingController numberCustomer = TextEditingController();

  var customer = <CustomerModel>[].obs;
  var customerActive = <CustomerModel>[].obs;
  Future<void> addCustomer() async{
    final name = nameCustomer.text;
    final number = numberCustomer.text;
    try {
      await ApiCustomer.addCustomerGarage(name, number);
      print("Success Add Customer");
      nameCustomer.clear();
      numberCustomer.clear();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchCustomer() async{
    try{
      final fetchData =  await ApiCustomer.fetchData();
      customer.assignAll(fetchData);
      print(customer.length);
    }catch(e){
      print(e.toString());
    }
  }
  Future<void> fetchCustomerActive() async{
    try{
      final fetchData =  await ApiCustomer.fetchActive();
      customerActive.assignAll(fetchData);
      // update();
    }catch(e){
      print(e.toString());
    }
  }

  Future<void> deleteCustomer(int id) async{
    customerActive.removeWhere((serv) => serv.id == id);
    update();
  }

  Future<void> customerEntry(int id) async{
    try{
      await ApiCustomer.customerEnteryGarage(id);
      EasyLoading.showSuccess('Entry has been made',
          maskType: EasyLoadingMaskType.black,
          duration: const Duration(milliseconds: 500));
    }catch(e){
      print("$e");
    }
  }

  Future<void> customerExite(int id) async{
    try{
      await ApiCustomer.customerExiteGarage(id);
      EasyLoading.showSuccess('Directed by',
          maskType: EasyLoadingMaskType.black,
          duration: const Duration(milliseconds: 500));
    }catch(e){
      print("$e");
    }
  }


  RxInt selectedIndexButtons = 0.obs;
  int get selectIndex => selectedIndexButtons.value;

  List<String> text = [
    "Active",
    "Non Active",
  ];
  void changeColor(int index) {
    selectedIndexButtons.value = index;
    update();
  }

  Color getColorButtons(int index) {
    return selectedIndexButtons.value == index ? darkblue : Colors.white;
  }
  Color getColorText(int index) {
    return selectedIndexButtons.value == index ? Colors.white : darkblue;
  }
  FontWeight changeStyle(int index) {
    return selectedIndexButtons.value == index
        ? FontWeight.bold
        : FontWeight.normal;
  }


  void showBookCustomer(int customerID,int parkingID,int floorID) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 170),
          child: AlertDialog(
            icon: const Icon(Icons.collections_bookmark_outlined, size: 50),
            title: const Text('Book For a Customer'),
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
                  addBook(customerID,parkingID,floorID);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
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
  Future<void> addBook(int customerID,int parkingID,int floorID) async{
    String formattedDateStart = DateFormat('HH:mm').format(dateTimeStart).padLeft(2, '0');
    String formattedDateEnd = DateFormat('HH:mm').format(dateTimeEnd).padLeft(2, '0');
    String formattedDate = DateFormat('y-MM-dd').format(dateTime);
    try{
          await ApiCustomer.addBookCustomer(customerID,parkingID,floorID,formattedDateStart,formattedDateEnd,formattedDate);
          EasyLoading.showSuccess('Successfully booked',
              maskType: EasyLoadingMaskType.black,
              duration: const Duration(milliseconds: 500));
          Get.back();
    }catch(e){
      print(e.toString());
    }
  }


}