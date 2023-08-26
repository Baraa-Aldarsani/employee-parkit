import 'package:employee_parking/model/user_sub_model.dart';

class SubscriptionModel {
  final int id;
  final double price;
  List<UserSubscriptionModel>? userSub;

  SubscriptionModel({required this.id, required this.price, this.userSub});

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    var subList = json['user_subscriptions'] as List<dynamic>;
    List<UserSubscriptionModel> sub = subList
        .map((floorJson) => UserSubscriptionModel.fromJson(floorJson))
        .toList();
    return SubscriptionModel(
      id: json['id'],
      price: double.parse(json['price'].toString()),
      userSub: sub,
    );
  }
}
