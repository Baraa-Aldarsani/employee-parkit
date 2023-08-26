import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/constant.dart';
import '../../model/garage_services_model.dart';
import '../../model/required_services_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<List<RequiredServicesModel>> fetchData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token') ?? 0;
    const url = '$baseUrl/showMyUsersServices';

    final response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data =
      json.decode(response.body)['required_services'];
      return data
          .map<RequiredServicesModel>(
              (json) => RequiredServicesModel.fromJson(json))
          .toList();
    } else {
      throw Exception('حدث خطأ أثناء تحميل الحدمات');
    }
  }

  static Future<void> done(int id) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token') ?? 0;
    const url = '$baseUrl/services_done';
    final response = await http.post(Uri.parse(url),body:{
      'id' : id.toString()
    },headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Success Done...");
    }
    else {
      throw Exception('حدث خطأ أثناء اتمام خدمة');
    }
    }

  static Future<List<GarageServices>> fetchServices() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token') ?? 0;
    const url = '$baseUrl/garage_employee_services';

    final response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data =
      json.decode(response.body)['garageServices'];
      return data
          .map<GarageServices>(
              (json) => GarageServices.fromJson(json))
          .toList();
    } else {
      throw Exception('حدث خطأ أثناء تحميل الحدمات الخاصة بالكراج');
    }
  }

  static Future<void> addServ(int userId,int servId) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token') ?? 0;
    const url = '$baseUrl/requestCustomerServices';
    final response = await http.post(Uri.parse(url),body:{
      'customer_id' : userId.toString(),
      'service_id' : servId.toString()
    },headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Success add customer Done...");
    }
    else {
      EasyLoading.showError('Failed Add',
          maskType: EasyLoadingMaskType.black,
          duration: const Duration(milliseconds: 500));
      throw Exception('حدث خطأ أثناء اضافة خدمة لزبون');
    }
  }
}
