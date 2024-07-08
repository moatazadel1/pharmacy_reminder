import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/cubit/user_cubit.dart';
import 'package:reminder_app/cubit/user_state.dart';
import 'package:reminder_app/models/all_products_model.dart';
import 'package:reminder_app/root_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/models/notification_model.dart'; // Make sure to import the new service

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    NotificationService
        .removeExpiredNotifications(); // Remove expired notifications on init
    BlocProvider.of<UserCubit>(context).allData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AllProductsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AllProductsSuccess) {
            final now = DateTime.now();
            final filteredProducts = state.products.data.where((product) {
              final expDate = DateFormat('yyyy-MM-dd').parse(product.expDate);
              return expDate.isAfter(now);
            }).toList();

            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 244, 243, 243),
                title: const Text(
                  "Scheduled Notifications",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF295c82)),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, RootScreen.id,
                        arguments: BlocProvider.of<UserCubit>(context)
                            .getUserProfile());
                  },
                ),
              ),
              body:
                  NotificationItemListView(filteredProducts: filteredProducts),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class NotificationItemListView extends StatelessWidget {
  const NotificationItemListView({
    super.key,
    required this.filteredProducts,
  });

  final List<ProductModel> filteredProducts;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(
            Icons.notifications,
            color: Color(0xFF295c82),
          ),
          title: Text(filteredProducts[index].title,
              style: TextStyle(
                  color: Color(0xFF295c82),
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          subtitle: Text(
              'The product "${filteredProducts[index].title}" will soon be about to expire on "${filteredProducts[index].expDate}" \nYou will receive a reminder notification on: ${filteredProducts[index].startReminder}',
              style: TextStyle(color: Colors.black, fontSize: 13)),
          isThreeLine: true,
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          thickness: 3,
          color: Color(0xFF295c82),
        );
      },
      itemCount: filteredProducts.length,
    );
  }
}

class NotificationService {
  static Future<void> removeExpiredNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> notifications = prefs.getStringList('notifications') ?? [];

    final now = DateTime.now();
    notifications.removeWhere((notificationString) {
      final notification =
          NotificationModel.fromMap(json.decode(notificationString));
      final scheduledDate =
          DateFormat('yyyy-MM-dd').parse(notification.scheduledDate);
      return scheduledDate.isBefore(now);
    });

    await prefs.setStringList('notifications', notifications);
  }
}
