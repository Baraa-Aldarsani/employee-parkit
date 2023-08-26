import 'package:employee_parking/model/parking_model.dart';

class FloorModel {
  final int id;
  final int number;
  List<ParkingModel>? parking;

  FloorModel({required this.id, required this.number, this.parking});

  factory FloorModel.fromJson(Map<String, dynamic> json,
      {bool includeParking = false}) {
    List<ParkingModel> parkings = [];
    if (includeParking) {
      var floorsList = json['parkings'] as List<dynamic>;
       parkings = floorsList
          .map((floorJson) => ParkingModel.fromJson(floorJson))
          .toList();
    }
    return FloorModel(
      id: json['id'],
      number: json['number'],
      parking: parkings,
    );
  }
}
