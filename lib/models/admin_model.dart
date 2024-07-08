import 'package:reminder_app/core/api/end_points.dart';

class AdminLoginModel {
  final bool status;
  final String api_token;
  final int id;
  final String name;
  final String email;

  AdminLoginModel({required this.status, required this.api_token,required this.id,required this.name,required this.email});

  //from json علشان هستقبلهم من الجيسون
  factory AdminLoginModel.fromJson(Map<String, dynamic> jsonData) {
    return AdminLoginModel(
      status: jsonData[ApiKey.status],
      id: jsonData['admin'][ApiKey.id] ?? 0,
      name: jsonData['admin'][ApiKey.name] ?? '',
      email: jsonData['admin'][ApiKey.email] ?? '',
      api_token: jsonData['admin'][ApiKey.api_token] ?? '',
    );
  }
}