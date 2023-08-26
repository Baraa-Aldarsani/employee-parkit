import 'package:employee_parking/model/garage_model.dart';
import 'package:employee_parking/view/add_customer_view.dart';
import 'package:employee_parking/view/all_customer_view.dart';
import 'package:employee_parking/view/customer_subscription.dart';
import 'package:employee_parking/view/login.dart';
import 'package:employee_parking/view/scan_camera_view.dart';
import 'package:employee_parking/view/all_user_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/home_view.dart';
import '../view/profile_view.dart';
import '../view/service_for_a_customer_view.dart';
import '../view/settings_view.dart';

class ControlController extends GetxController {
  GlobalKey<ScaffoldState> openDrawer = GlobalKey<ScaffoldState>();
  Widget _currentScreen =  HomeView();
  get currentScreen => _currentScreen;

  void changeSelectedValue(int selected,{int floor = 0,int parking = 0,String barcode = ''}) {

    update();
    switch (selected) {
      case 0:
        {
          _currentScreen =  HomeView();
          break;
        }
      case 1:
        {
          _currentScreen = ScanCameraView();
          break;
        }
      case 2:
        {
          _currentScreen = AddCustomerView();
          break;
        }
      case 3:
        {
          _currentScreen =  ServiceForCustomerView();
          break;
        }
      case 4:
        {
          _currentScreen =  CustomerSubscription();
          break;
        }
      case 5:
        {
          _currentScreen = AllCustomerView(floor: floor,parkingID: parking);
          break;
        }
      case 6:
        {
          _currentScreen =  ProfileView();
          break;
        }
      case 7:
        {
          _currentScreen =  SettingsView();
          break;
        }
      case 8:
        {
          _currentScreen = AllUser(barcode: barcode,floor: floor,parkingID: parking);
          break;
        }
    }
  }
}
