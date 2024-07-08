import 'dart:convert';
import 'package:reminder_app/core/api/end_points.dart';


// Function to parse a list of users from a JSON response
List<AllUsersModel> parseUsers(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<AllUsersModel>((json) => AllUsersModel.fromJson(json)).toList();
}
class AllUsersModel {
  final int id;
  final String name;
  final String email;
  
  AllUsersModel({required this.name,required this.email, required this.id});

  factory AllUsersModel.fromJson(Map<String, dynamic> jsonData) {
    return AllUsersModel(
        id: jsonData[ApiKey.id] ?? 0,
        name: jsonData[ApiKey.name] ?? " ",
        email: jsonData[ApiKey.email] ?? " ",
        );
  }
}