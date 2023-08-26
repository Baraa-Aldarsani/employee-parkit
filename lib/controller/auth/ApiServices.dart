import 'dart:convert';

import '../../helper/constant.dart';
import '../../model/employee_model.dart';
import 'package:http/http.dart' as http;

class ApiService{
  static Future<EmployeeModel> signInWithEmailAndPassword(
      String email, String password) async {
    const url = '$baseUrl/employee-login';
    final body = jsonEncode({'email': email, 'password': password});
    final headers = {'Content-Type': 'application/json'};
    final response =
    await http.post(Uri.parse(url), headers: headers, body: body);
    // print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      return EmployeeModel.fromJson(responseData);
    } else {
      throw Exception('حدث خطأ أثناء تسجيل الدخول');
    }
  }
}