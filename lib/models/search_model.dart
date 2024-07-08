import 'package:reminder_app/core/api/end_points.dart';

class SearchModel {
  final List<SearchItem> items;

  SearchModel({required this.items});

  factory SearchModel.fromJson(Map<String, dynamic> jsonData) {
    List<SearchItem> search = List<SearchItem>.from(jsonData['data']
        .map((productJson) => SearchItem.fromJson(productJson)));
    return SearchModel(items: search);
  }
}

class SearchItem {
  final int quantity;
  final String title;
  final String description;
  final String itemImage;
  final String type;
  final String expDate;

  SearchItem({
    required this.quantity,
    required this.title,
    required this.description,
    required this.itemImage,
    required this.type,
    required this.expDate,
  });

  factory SearchItem.fromJson(Map<String, dynamic> json) {
    return SearchItem(
      title: json[ApiKey.title] ?? '',
      quantity: json[ApiKey.quantity] ?? 0,
      description: json[ApiKey.description] ?? '',
      itemImage: json[ApiKey.item_image] ?? '',
      type: json[ApiKey.type] ?? '',
      expDate: json[ApiKey.exp_date] ?? '',
    );
  }
}
