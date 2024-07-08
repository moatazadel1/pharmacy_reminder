import 'package:reminder_app/core/api/end_points.dart';

class CategoriesItemsModel {
  final String pills;
  final String syrub;
  
  CategoriesItemsModel({required this.pills,required this.syrub});

  factory CategoriesItemsModel.fromJson(Map<String, dynamic> jsonData) {
    return CategoriesItemsModel(
        pills: jsonData[ApiKey.name] ?? " ",
        syrub: jsonData[ApiKey.email] ?? " ",
        );
  }
}