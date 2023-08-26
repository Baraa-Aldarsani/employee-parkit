// ignore_for_file: non_constant_identifier_names

import 'garage_model.dart';

class EmployeeModel {
  final int id;
  final String name;
  final int phone_number;
  final String email;
  final String address;
  final String token;
  GarageModel? garageModel;
  int? gID;

  EmployeeModel({
    required this.id,
    required this.name,
    required this.phone_number,
    required this.email,
    required this.address,
    required this.token,
    this.garageModel,
    this.gID,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json,
      {bool include = false, bool fetch = false}) {
    if (include) {
      return EmployeeModel(
          id: json['id'],
          name: json['name'],
          phone_number: json['phone_number'],
          email: json['email'],
          address: json['address'],
          token: '',
          garageModel: GarageModel.fromJson(json['garage_id']));
    } else if (fetch) {
      return EmployeeModel(
        id: json['id'],
        name: json['name'],
        phone_number: json['phone_number'],
        email: json['email'],
        address: json['address'],
        token: '',
      );
    } else {
      return EmployeeModel(
        id: json['garage']['id'],
        name: json['garage']['name'],
        phone_number: json['garage']['phone_number'],
        email: json['garage']['email'],
        address: json['garage']['address'],
        gID: json['garage']['garage_id'],
        token: json['token']['token'],
      );
    }
  }
}
