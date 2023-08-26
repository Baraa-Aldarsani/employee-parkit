import 'status_parking_model.dart';

class ParkingModel {
  final int id;
  final String number;
  StatusParkingModel? status;

  ParkingModel({required this.id, required this.number, this.status});

  factory ParkingModel.fromJson(Map<String, dynamic> json) {
    return ParkingModel(
      id: json['id'],
      number: json['number'],
      status: StatusParkingModel.fromJson(json['status']),
    );
  }
}
