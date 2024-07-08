import 'dart:convert';
import 'package:reminder_app/core/api/end_points.dart';


// Function to parse a list of users from a JSON response
List<LatestItemsModel> parseUsers(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<LatestItemsModel>((json) => LatestItemsModel.fromJson(json)).toList();
}
class LatestItemsModel {
  final String title;
  final int quantity;
  final int code;
  final int id;
  
  LatestItemsModel({required this.quantity,required this.code, required this.title, required this.id});

  factory LatestItemsModel.fromJson(Map<String, dynamic> jsonData) {
    return LatestItemsModel(
        title: jsonData[ApiKey.title] ?? " ",
        quantity: jsonData[ApiKey.quantity] ?? 0,
        code: jsonData[ApiKey.code] ?? 0,
        id: jsonData[ApiKey.id] ?? 0
        );
  }
}