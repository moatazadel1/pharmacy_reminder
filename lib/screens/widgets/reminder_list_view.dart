import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../cubit/user_cubit.dart';
import '../../cubit/user_state.dart';
import 'notification_reminder_list_view.dart';

class RemindersListView extends StatelessWidget {
  const RemindersListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      buildWhen: (previous, current) =>
          current is AllProductsLoading ||
          current is AllProductsSuccess ||
          current is AllProductsFailure,
      builder: (context, state) {
        if (state is AllProductsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AllProductsSuccess) {
          final now = DateTime.now();
          final filteredProducts = state.products.data.where((product) {
            final expDate = DateFormat('yyyy-MM-dd').parse(product.expDate);
            return expDate.isAfter(now);
          }).toList();

          return NotificationReminderListView(
              filteredProduct:
                  filteredProducts.isNotEmpty ? filteredProducts.last : null);
        } else if (state is AllProductsFailure) {
          return Text(state.errMessage);
        } else {
          return const Center(child: Text(''));
        }
      },
    );
  }
}
