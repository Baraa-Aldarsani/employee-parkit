import 'package:employee_parking/model/user_model.dart';

class UserSubscriptionModel {
  final int id;
  final String startDate;
  final String endDate;
  final UserModel userModel;
  UserSubscriptionModel(
      {required this.id, required this.startDate, required this.endDate,required this.userModel});

  factory UserSubscriptionModel.fromJson(Map<String, dynamic> json) {

    return UserSubscriptionModel(
        id: json['id'],
        startDate: json['start_date_sub'],
        endDate: json['end_date_sub'],
        userModel: UserModel.fromJson(json['users'])
    );
  }
}
