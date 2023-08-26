import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helper/constant.dart';
import '../../model/employee_model.dart';
import 'package:http/http.dart' as http;

class ApiServicesUser{
  static Future<EmployeeModel> getEmployeeInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.get('token') ?? 0;
    final id = preferences.get('ID') ?? 0;
    final response = await http.get(Uri.parse('$baseUrl/showAccountEmployees/$id'),headers: {'Authorization' : 'Bearer $token'});

    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = json.decode(response.body);
      return EmployeeModel.fromJson(jsonData,fetch: true);
    } else {
      throw Exception('Failed to fetch user');
    }
  }
}