import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app/models/category_model.dart';
import 'package:reminder_app/widgets/category_card.dart';
import '../cubit/user_cubit.dart';

class CategorisListView extends StatefulWidget {
  const CategorisListView({
    super.key,
  });

  @override
  State<CategorisListView> createState() => CategorisListViewState();
}

class CategorisListViewState extends State<CategorisListView> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Map<String, int> itemCounts = {
    'Pills': 1,
    'Syrup': 10,
    'Injection': 20,
    'Body Care': 12,
    'Skin Care': 42,
    'Hair Care': 30,
  };

  void fetchData() async {
    try {
      final response =
          await BlocProvider.of<UserCubit>(context).fetchAdminDashboardData();

      setState(() {
        itemCounts = {
          'Pills': response['Pills']?['count'] ?? 0,
          'Syrup': response['Syrup']?['count'] ?? 0,
          'Injection': response['Injection']?['count'] ?? 0,
          'Body Care': response['Body']?['count'] ?? 0,
          'Skin Care': response['Skin']?['count'] ?? 0,
          'Hair Care': response['Hair']?['count'] ?? 0,
        };
      });
    } catch (e) {
      log('Error fetching dashboard data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categories = [
      CategoryModel(
          categoryName: "Pills",
          categoryPrecent: itemCounts['Pills'].toString(),
          categoryImage: "images/pills.png"),
      CategoryModel(
          categoryName: "Injections",
          categoryPrecent: itemCounts['Syrup'].toString(),
          categoryImage: "images/injections.png"),
      CategoryModel(
          categoryName: "syrup",
          categoryPrecent: itemCounts['Injection'].toString(),
          categoryImage: "images/syrup.png"),
      CategoryModel(
          categoryName: "other products",
          categoryPrecent: itemCounts['Body Care'].toString(),
          categoryImage: "images/others.png")
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryCard(
            category: categories[index],
          );
        },
      ),
    );
  }
}
