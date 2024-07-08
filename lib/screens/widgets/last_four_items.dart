import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/user_cubit.dart';
import '../../cubit/user_state.dart';

class Last4Items extends StatelessWidget {
  const Last4Items({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      buildWhen: (previous, current) =>
          current is LatestItemsLoading ||
          current is LatestItemsSuccess ||
          current is LatestItemsFailure,
      builder: (context, state) {
        if (state is LatestItemsLoading) {
          return const CircularProgressIndicator();
        } else if (state is LatestItemsSuccess) {
          final items = state.items.take(4).toList();
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 220, top: 10, bottom: 5),
                child: Text(
                  "Last 4 Items:",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 20.0,
                    columns: const [
                      DataColumn(label: Center(child: Text('Name'))),
                      DataColumn(label: Center(child: Text('Quantity'))),
                      DataColumn(label: Center(child: Text('Code'))),
                      DataColumn(label: Center(child: Text('Delete'))),
                    ],
                    rows: items.map<DataRow>((item) {
                      return DataRow(cells: [
                        DataCell(Text(item.title)),
                        DataCell(Text(item.quantity.toString())),
                        DataCell(Text(item.code.toString())),
                        DataCell(
                          IconButton(
                            icon: const Icon(Icons.delete,
                                color: Colors.red, size: 24),
                            onPressed: () {
                              context.read<UserCubit>().deleteItem(item.id);
                            },
                          ),
                        ),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ],
          );
        } else if (state is LatestItemsFailure) {
          return Text(state.errmessage);
        } else {
          return const Text('No data available');
        }
      },
    );
  }
}
