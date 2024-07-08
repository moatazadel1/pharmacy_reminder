import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app/cubit/user_cubit.dart';
import 'package:reminder_app/screens/admin.dart';
import 'package:reminder_app/screens/create_admin.dart';
import '../cubit/user_state.dart';
import 'widgets/last_four_items.dart';
import 'widgets/last_four_users.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  static String id = 'Dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    final userCubit = BlocProvider.of<UserCubit>(context);
    userCubit.allusers();
    userCubit.latestItems();
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 244, 243, 243),
        title: const Text(
          "Dashboard",
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Color(0xFF295c82)),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<UserCubit>().adminlogOut();
              Navigator.pushReplacementNamed(context, CreateAdmin.id);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 70),
                    child: Row(
                      children: [
                        BlocBuilder<UserCubit, UserState>(
                          buildWhen: (previous, current) =>
                              current is AllUsersLoading ||
                              current is AllUsersSuccess ||
                              current is AllUsersFailure,
                          builder: (context, state) {
                            int userCount = 0;
                            if (state is AllUsersSuccess) {
                              userCount = state.users.length;
                            }
                            return Container(
                              height: 50,
                              width: 50,
                              color: const Color(0xFFee8524),
                              child: Center(
                                child: Text(
                                  userCount.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(Admin.id);
                          },
                          child: Container(
                            height: 50,
                            width: 150,
                            color: const Color(0xFFececec),
                            child: const Center(
                              child: Text("Number of Users"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          color: const Color.fromARGB(255, 237, 113, 187),
                          child: Center(
                              child: Text(
                            itemCounts['Pills'].toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          )),
                        ),
                        Container(
                          height: 50,
                          width: 100,
                          color: const Color(0xFFececec),
                          child: const Center(child: Text("Pills")),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          color: const Color.fromARGB(255, 169, 26, 160),
                          child: Center(
                              child: Text(
                            itemCounts['Syrup'].toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          )),
                        ),
                        Container(
                          height: 50,
                          width: 100,
                          color: const Color(0xFFececec),
                          child: const Center(child: Text("Syrup")),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          color: const Color.fromARGB(255, 73, 179, 189),
                          child: Center(
                              child: Text(
                            itemCounts['Injection'].toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          )),
                        ),
                        Container(
                          height: 50,
                          width: 100,
                          color: const Color(0xFFececec),
                          child: const Center(child: Text("Injections")),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          color: const Color(0xFFdc0d0d),
                          child: Center(
                              child: Text(
                            itemCounts['Body Care'].toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          )),
                        ),
                        Container(
                          height: 50,
                          width: 100,
                          color: const Color(0xFFececec),
                          child: const Center(child: Text("Body Care")),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          color: const Color(0xFF79c519),
                          child: Center(
                              child: Text(
                            itemCounts['Skin Care'].toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          )),
                        ),
                        Container(
                          height: 50,
                          width: 100,
                          color: const Color(0xFFececec),
                          child: const Center(child: Text("Skin Care")),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          color: const Color.fromARGB(255, 32, 124, 194),
                          child: Center(
                              child: Text(
                            itemCounts['Hair Care'].toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          )),
                        ),
                        Container(
                          height: 50,
                          width: 100,
                          color: const Color(0xFFececec),
                          child: const Center(child: Text("Hair Care")),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const Last4Users(),
              const Last4Items(),
            ],
          ),
        ),
      ),
    );
  }
}
