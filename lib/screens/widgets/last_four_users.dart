import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/user_cubit.dart';
import '../../cubit/user_state.dart';

class Last4Users extends StatelessWidget {
  const Last4Users({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      buildWhen: (previous, current) =>
          current is AllUsersLoading ||
          current is AllUsersSuccess ||
          current is AllUsersFailure,
      builder: (context, state) {
        if (state is AllUsersLoading) {
          return const CircularProgressIndicator();
        } else if (state is AllUsersSuccess) {
          final users = state.users.take(4).toList();
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 220, top: 10, bottom: 5),
                child: Text(
                  "Last 4 Users:",
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
                      DataColumn(label: Center(child: Text('Email'))),
                      DataColumn(label: Center(child: Text('Delete'))),
                    ],
                    rows: users.map<DataRow>((user) {
                      return DataRow(cells: [
                        DataCell(Text(user.name)),
                        DataCell(Text(user.email)),
                        DataCell(
                          IconButton(
                            icon: const Icon(Icons.delete,
                                color: Colors.red, size: 24),
                            onPressed: () {
                              context.read<UserCubit>().deleteUser(user.id);
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
        } else if (state is AllUsersFailure) {
          return Text(state.errmessage);
        } else {
          return const Text('No data available');
        }
      },
    );
  }
}
