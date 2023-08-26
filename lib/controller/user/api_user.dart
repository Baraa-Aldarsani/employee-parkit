// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:employee_parking/model/reservation_model.dart';
import 'package:employee_parking/model/user_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../helper/constant.dart';

class ApiUser {
  static Future<void> userEnteryGarage(String id, String carID) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token') ?? 0;
    final response = await http.post(Uri.parse('$baseUrl/userEntry'), body: {
      'user_id': id,
      'car_id': carID,
    }, headers: {
      'Authorization': 'Bearer $token'
    });
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Entry User");
    } else {
      EasyLoading.showError('car inside garage',
          maskType: EasyLoadingMaskType.black,
          duration: const Duration(milliseconds: 500));
      throw Exception('Failed to entry user');
    }
  }

  static Future<void> userExiteGarage(String id, String carID) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token') ?? 0;
    final response = await http.post(Uri.parse('$baseUrl/exitUser'), body: {
      'car_id': carID,
      'user_id': id,
    }, headers: {
      'Authorization': 'Bearer $token'
    });
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Exit User");
    } else {
      EasyLoading.showError('car outside garage',
          maskType: EasyLoadingMaskType.black,
          duration: const Duration(milliseconds: 500));
      throw Exception('Failed to exite user');
    }
  }

  static Future<List<ReservationModel>> fetchReserv() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token') ?? 0;
    final response = await http.get(Uri.parse('$baseUrl/getUsersReservations'),
        headers: {'Authorization': 'Bearer $token'});
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data = json.decode(response.body)['reservations'];
      return data
          .map<ReservationModel>((json) => ReservationModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to fetch reservation');
    }
  }

  static Future<List<UserModel>> fetchActiveUsers() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token') ?? 0;
    final response = await http.get(
        Uri.parse('$baseUrl/getActiveUserWithWallet'),
        headers: {'Authorization': 'Bearer $token'});
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .map<UserModel>((json) => UserModel.fromJson(json, include: true))
          .toList();
    } else {
      throw Exception('Failed to fetch Active User');
    }
  }

  static Future<void> addBookUser(int userId, int carId, int parkingID,
      int floorID, String startTime, String endTime, String date) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token') ?? 0;
    final response = await http.post(Uri.parse('$baseUrl/wParkuser'), body: {
      'user_id': userId.toString(),
      'time_begin': startTime,
      'time_end': endTime,
      'date': date,
      'parking_id': parkingID.toString(),
      'floor_id': floorID.toString(),
      'car_id': carId.toString(),
    }, headers: {
      'Authorization': 'Bearer $token'
    });

    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Success Add Book for a user");
    } else {
      EasyLoading.showError('Failed booking',
          maskType: EasyLoadingMaskType.black,
          duration: const Duration(milliseconds: 500));
      throw Exception('Failed to add book for a user');
    }
  }

  static Future<void> makePayment(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token') ?? 0;

    final response = await http.post(Uri.parse('$baseUrl/makePayment'),
        body: {'user_id': id}, headers: {'Authorization': 'Bearer $token'});

    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("تم خصم المبلغ المطلوب بنجاح من المحفظة");
    } else {
      EasyLoading.showError('Failed booking',
          maskType: EasyLoadingMaskType.black,
          duration: const Duration(milliseconds: 500));
      throw Exception('Failed to payment for a user');
    }
  }
}
