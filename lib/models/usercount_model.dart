import 'package:reminder_app/core/api/end_points.dart';

class UserCountModel {
  final int user_count;
  
  UserCountModel({required this.user_count});

  factory UserCountModel.fromJson(Map<String, dynamic> jsonData) {
    return UserCountModel(
        user_count: jsonData[ApiKey.user_count] ?? 0,
        );
  }
}