import 'package:reminder_app/core/api/end_points.dart';

class SoonSearchModel {
  final List<SearchItem2> items;

  SoonSearchModel({required this.items});

  factory SoonSearchModel.fromJson(Map<String, dynamic> jsonData) {
    List<SearchItem2> search = List<SearchItem2>.from(jsonData['data']
        .map((productJson) => SearchItem2.fromJson(productJson)));
    return SoonSearchModel(items: search);
  }
}

class SearchItem2 {
  final int quantity;
  final String title;
  final String description;
  final String itemImage;
  final String type;
  final String expDate;

  SearchItem2({
    required this.quantity,
    required this.title,
    required this.description,
    required this.itemImage,
    required this.type,
    required this.expDate,
  });

  factory SearchItem2.fromJson(Map<String, dynamic> json) {
    return SearchItem2(
      title: json[ApiKey.title] ?? '',
      quantity: json[ApiKey.quantity] ?? 0,
      description: json[ApiKey.description] ?? '',
      itemImage: json[ApiKey.item_image] ?? '',
      type: json[ApiKey.type] ?? '',
      expDate: json[ApiKey.exp_date] ?? '',
    );
  }
}
