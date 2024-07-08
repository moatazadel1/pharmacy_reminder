import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app/cubit/user_cubit.dart';
import 'package:reminder_app/cubit/user_state.dart';

class Admin extends StatefulWidget {
  static String id = 'Admin';
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  void initState() {
    super.initState();
    // Fetch user count and all users concurrently when the dashboard is initialized
    final userCubit =
        BlocProvider.of<UserCubit>(context); // Start fetching user count
    userCubit.allusers(); // Start fetching all users
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is DeleteUserSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('user deleted successfully'),
            ),
          );
          BlocProvider.of<UserCubit>(context).allusers();
        } else if (state is DeleteUserFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errMessage)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 244, 243, 243),
            title: const Text(
              "Users",
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            leading: const BackButton(color: Color(0xFF295c82)),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Center(
              child: Column(
                children: [
                  DataTable(
                    columnSpacing: 25.0,
                    columns: const [
                      DataColumn(
                          label: Expanded(child: Center(child: Text('Name')))),
                      DataColumn(
                          label: Expanded(child: Center(child: Text('Email')))),
                      DataColumn(
                          label:
                              Expanded(child: Center(child: Text('Delete')))),
                    ],
                    rows: state is AllUsersSuccess
                        ? state.users.map<DataRow>((user) {
                            return DataRow(cells: [
                              DataCell(Text(user.name)),
                              DataCell(Text(user.email)),
                              DataCell(
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red, size: 24),
                                  onPressed: () {
                                    // Handle delete action
                                    context
                                        .read<UserCubit>()
                                        .deleteUser(user.id);
                                  },
                                ),
                              ),
                            ]);
                          }).toList()
                        : [],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
