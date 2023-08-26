// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/constant.dart';
import 'package:http/http.dart' as http;

import '../../model/customer_model.dart';

class ApiCustomer {
  static Future<void> addCustomerGarage(String name, String number) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    const url = '$baseUrl/addCustmer';
    final response = await http.post(Uri.parse(url), body: {
      'name': name,
      'number': number,
    }, headers: {
      'Authorization': 'Bearer $token'
    });
    // print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Success add");
    } else {
      throw Exception('حدث خطأ أثناء اضافة زبون');
    }
  }

  static Future<List<CustomerModel>> fetchData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    const url = '$baseUrl/getCustomersInGarage';
    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );
    // print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data =
      json.decode(response.body);
          return data
              .map<CustomerModel>(
                  (json) => CustomerModel.fromJson(json))
              .toList();
    } else {
      throw Exception('Failed fetch Customer');
    }
  }

  static Future<List<CustomerModel>> fetchActive() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    const url = '$baseUrl/getActiveCustomer';
    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data =
      json.decode(response.body);
      return data
          .map<CustomerModel>(
              (json) => CustomerModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed fetch Customer');
    }
  }

  static Future<void> customerEnteryGarage(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token') ?? 0;
    final response =
        await http.post(Uri.parse('$baseUrl/customerEntry'), body: {
      'customer_id': id.toString(),
    }, headers: {
      'Authorization': 'Bearer $token'
    });
    // print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Entry Customer");
    } else {
      throw Exception('Failed to entry customer');
    }
  }

  static Future<void> customerExiteGarage(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token') ?? 0;
    final response = await http.post(Uri.parse('$baseUrl/exitCustomer'), body: {
      'customer_id': id.toString(),
    }, headers: {
      'Authorization': 'Bearer $token'
    });
    // print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Exit Customer");
    } else {
      throw Exception('Failed to exite customer');
    }
  }

  static Future<void> addBookCustomer(int customerID,int parkingID,int floorID,String startTime,String endTime,String date) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token') ?? 0;
    // print(customerID);
    // print(startTime);
    // print(endTime);
    // print(date);
    // print(parkingID);
    // print(floorID);
    final response = await http.post(Uri.parse('$baseUrl/wParkCustomer'), body: {
      'customer_id': customerID.toString(),
      'time_begin': startTime,
      'time_end': endTime,
      'date': date,
      'parking_id': parkingID.toString(),
      'floor_id': floorID.toString(),
    }, headers: {
      'Authorization': 'Bearer $token'
    });

    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Success Add Book for a customer");
    } else {
      EasyLoading.showError('Failed booking',
          maskType: EasyLoadingMaskType.black,
          duration: const Duration(milliseconds: 500));
      throw Exception('Failed to add book for a customer');
    }
  }
}
