import 'package:reminder_app/core/api/end_points.dart';

class ExSearchModel {
  final List<SearchItem1> items;

  ExSearchModel({required this.items});

  factory ExSearchModel.fromJson(Map<String, dynamic> jsonData) {
    List<SearchItem1> search = List<SearchItem1>.from(jsonData['data']
        .map((productJson) => SearchItem1.fromJson(productJson)));
    return ExSearchModel(items: search);
  }
}

class SearchItem1 {
  final int quantity;
  final String title;
  final String description;
  final String itemImage;
  final String type;
  final String expDate;

  SearchItem1({
    required this.quantity,
    required this.title,
    required this.description,
    required this.itemImage,
    required this.type,
    required this.expDate,
  });

  factory SearchItem1.fromJson(Map<String, dynamic> json) {
    return SearchItem1(
      title: json[ApiKey.title] ?? '',
      quantity: json[ApiKey.quantity] ?? 0,
      description: json[ApiKey.description] ?? '',
      itemImage: json[ApiKey.item_image] ?? '',
      type: json[ApiKey.type] ?? '',
      expDate: json[ApiKey.exp_date] ?? '',
    );
  }
}
