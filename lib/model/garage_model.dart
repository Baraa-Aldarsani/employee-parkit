// ignore_for_file: non_constant_identifier_names
import 'floor_model.dart';
import 'subscription_model.dart';

class GarageModel {
  final int id;
  final String name;
  final double price_per_hour;
  final String time_open;
  final String time_close;
  List<FloorModel>? floor;
  List<SubscriptionModel>? subscription;
  GarageModel({
    required this.name,
    required this.id,
    required this.price_per_hour,
    required this.time_open,
    required this.time_close,
    this.floor,
    this.subscription,
  });

  factory GarageModel.fromJson(Map<String, dynamic> json,{bool includeFloor = false,bool includeSub = false}) {
    List<FloorModel> floors = [];
    if(includeFloor){
      var floorsList = json['floors'] as List<dynamic>;
      floors = floorsList.map((floorJson) =>
          FloorModel.fromJson(floorJson,includeParking: true)).toList();
    }
    List<SubscriptionModel> subscriptionList = [];
    if(includeSub){
      var subList = json['garage_subscriptions'] as List<dynamic>;
      subscriptionList = subList.map((subJson) =>
          SubscriptionModel.fromJson(subJson)).toList();
    }
    return GarageModel(
      id: json['id'],
      name: json['name'],
      price_per_hour: double.parse(json['price_per_hour'].toString()),
      time_open: json['time_open'],
      time_close: json['time_close'],
      floor: floors,
      subscription: subscriptionList,
    );
  }
}
