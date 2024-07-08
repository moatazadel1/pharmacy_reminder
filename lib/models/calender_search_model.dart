import 'package:reminder_app/core/api/end_points.dart';

class SearchCalenderModel {
  final List<SearchCalenderItem> items;

  SearchCalenderModel({required this.items});

  factory SearchCalenderModel.fromJson(Map<String, dynamic> jsonData) {
    List<SearchCalenderItem> search = List<SearchCalenderItem>.from(jsonData['data']
        .map((productJson) => SearchCalenderItem.fromJson(productJson)));
    return SearchCalenderModel(items: search);
  }
}

class SearchCalenderItem {
  final int quantity;
  final String title;
  final String description;
  final String itemImage;
  final String type;
  final String expDate;

  SearchCalenderItem({
    required this.quantity,
    required this.title,
    required this.description,
    required this.itemImage,
    required this.type,
    required this.expDate,
  });

  factory SearchCalenderItem.fromJson(Map<String, dynamic> json) {
    return SearchCalenderItem(
      title: json[ApiKey.title] ?? '',
      quantity: json[ApiKey.quantity] ?? 0,
      description: json[ApiKey.description] ?? '',
      itemImage: json[ApiKey.item_image] ?? '',
      type: json[ApiKey.type] ?? '',
      expDate: json[ApiKey.exp_date] ?? '',
    );
  }
}
