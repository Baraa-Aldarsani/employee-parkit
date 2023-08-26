import 'package:employee_parking/model/garage_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../helper/constant.dart';
import 'dart:convert';

class ApiServices{
    static Future<GarageModel> getSubUser1() async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final id = preferences.getString('GID') ?? 0;
      final response = await http.get(
          Uri.parse('$baseUrl/user-garage-subscription/$id'));
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return GarageModel.fromJson(json.decode(response.body)['subscribed_users on spicific garage'],includeSub: true);
      } else {
        throw Exception('Failed to fetch Garage');
      }

    }
}