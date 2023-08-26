// ignore_for_file: non_constant_identifier_names

class ReservationModel {
  final int id;
  final String date;
  final String time_begin;
  final String time_end;
  final String time_reservation;
  final double price;
  final double pay;
  final String barcode;
  final int parking_id;
  final int floor_id;
  final int car_id;

  ReservationModel({
    required this.id,
    required this.date,
    required this.time_begin,
    required this.time_end,
    required this.time_reservation,
    required this.price,
    required this.pay,
    required this.barcode,
    required this.parking_id,
    required this.floor_id,
    required this.car_id,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      id: json['id'],
      date: json['date'],
      time_begin: json['time_begin'],
      time_end: json['time_end'],
      time_reservation: json['time_reservation'],
      price: double.parse(json['price'].toString()),
      pay: double.parse(json['pay'].toString()),
      barcode: json['barcode'],
      parking_id: json['parking_id'],
      floor_id: json['floor_id'],
      car_id: json['car_id'],
    );
  }
}
