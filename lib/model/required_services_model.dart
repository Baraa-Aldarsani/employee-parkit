import 'package:employee_parking/model/user_model.dart';

import 'services_model.dart';

class RequiredServicesModel {
  final int id;
  int done;
  final ServicesModel serviceInfo;
  final UserModel userModel;

  RequiredServicesModel({
    required this.id,
    required this.done,
    required this.serviceInfo,
    required this.userModel,
  });

  factory RequiredServicesModel.fromJson(Map<String, dynamic> json) {
    return RequiredServicesModel(
      id: json['id'],
      done: json['done'],
      serviceInfo: ServicesModel.fromJson(json['services']),
      userModel: UserModel.fromJson(json['user']),
    );
  }
}
