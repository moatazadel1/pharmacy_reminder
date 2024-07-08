import 'package:reminder_app/core/api/end_points.dart';

class AdminLogOutModel {
  
  final String msg;

  AdminLogOutModel({ required this.msg});

  
  factory AdminLogOutModel.fromJson(Map<String, dynamic> jsonData) {
    return AdminLogOutModel(
      
      msg: jsonData[ApiKey.msg],
    );
  }
}