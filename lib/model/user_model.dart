import 'package:employee_parking/model/reservation_model.dart';

class UserModel {
  final int id;
  final String name;
  final String nickName;
  final String phone;
  final String gender;
  final String image;
  int? carID;
  List<ReservationModel>? reservation;
  UserModel({
    required this.id,
    required this.name,
    required this.nickName,
    required this.phone,
    required this.gender,
    required this.image,
    this.reservation,
    this.carID,
  });

  factory UserModel.fromJson(Map<String, dynamic> json,{bool include = false}) {

    List<ReservationModel> reservations = [];
    int carId = 0;
    if (include) {
      var resList = json['reservations'] as List<dynamic>;
      reservations = resList
          .map((resJson) => ReservationModel.fromJson(resJson))
          .toList();
      carId = json['car_id'];
    }
    return UserModel(
      id: json['id'],
      name: json['name'],
      nickName: json['nickname'],
      phone: json['phone_number'],
      gender: json['gender'],
      image: json['image_link'],
      reservation: reservations,
      carID: carId,
    );
  }
}
