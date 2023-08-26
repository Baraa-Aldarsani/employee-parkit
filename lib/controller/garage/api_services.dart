import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../helper/constant.dart';
import '../../model/garage_model.dart';

class ApiServices{
  static Future<GarageModel> getGarage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final id = preferences.getString('GID') ?? 0;
    final response = await http.get(
        Uri.parse('$baseUrl/garages/$id/parking'));
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return GarageModel.fromJson(json.decode(response.body)['garage'],includeFloor: true);
    } else {
      throw Exception('Failed to fetch Garage');
    }
  }
}