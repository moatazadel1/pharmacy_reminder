import 'package:flutter/material.dart';
import 'package:reminder_app/models/all_products_model.dart';

class NotificationReminderListView extends StatelessWidget {
  const NotificationReminderListView({
    super.key,
    required this.filteredProduct,
  });

  final ProductModel? filteredProduct;

  @override
  Widget build(BuildContext context) {
    if (filteredProduct == null) {
      return const Center(child: Text('No upcoming reminders.'));
    }

    return ListTile(
      title: Text(filteredProduct!.title),
      subtitle: Text(
        'The product "${filteredProduct!.title}" will soon be about to expire on "${filteredProduct!.expDate}" \nYou will receive a reminder notification on: ${filteredProduct!.startReminder}',
      ),
      isThreeLine: true,
    );
  }
}
