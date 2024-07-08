import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app/components/homeSearchfield.dart';
import 'package:reminder_app/cubit/user_cubit.dart';
import 'package:reminder_app/screens/all_items.dart';
import 'package:reminder_app/screens/expired.dart';
import 'package:reminder_app/screens/notifications.dart';
import 'package:reminder_app/screens/soon_to_expire.dart';
import 'package:reminder_app/screens/widgets/custom_profile_view.dart';
import 'package:reminder_app/widgets/categories_list_view.dart';
import 'widgets/reminder_list_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static String id = 'homeScreen';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserCubit>(context).getUserProfile();
    BlocProvider.of<UserCubit>(context)
        .allData(); // Fetch all data for notifications
    NotificationService
        .removeExpiredNotifications(); // Remove expired notifications on init
    BlocProvider.of<UserCubit>(context).allData();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomProfileView(),
              const SizedBox(height: 10),
              const HomeSearchField(),
              Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.sizeOf(context).width * 0.7),
                child: const Text(
                  "Recent",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CategorisListView(),
              ),
              const SizedBox(height: 10),
              Container(
                height: 50,
                width: 340,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border:
                      Border.all(color: const Color(0xFF295c82), width: 1.5),
                ),
                child: ListTile(
                  title: const Text(
                    "All Items",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  leading: const Icon(Icons.list,
                      color: Color(0xFF295c82), size: 25),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 25),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const AllItems();
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 50,
                width: 340,
                decoration: BoxDecoration(
                  color: const Color(0xFF295c82),
                  borderRadius: BorderRadius.circular(16),
                  border:
                      Border.all(color: const Color(0xFF295c82), width: 1.5),
                ),
                child: ListTile(
                  title: const Text(
                    "Soon To Expire",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  leading: const Icon(Icons.timelapse,
                      color: Colors.white, size: 25),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      size: 25, color: Colors.white),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const SoonToExpire();
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 50,
                width: 340,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border:
                      Border.all(color: const Color(0xFF295c82), width: 1.5),
                ),
                child: ListTile(
                  title: const Text(
                    "Expired",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  leading: const Icon(Icons.format_indent_increase,
                      color: Color(0xFF295c82), size: 25),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 25),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const Expired();
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                      "All Reminders",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return const NotificationsScreen();
                        }),
                      );
                    },
                    child: const Text(
                      "See All",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF295c82),
                      ),
                    ),
                  ),
                ],
              ),
              const RemindersListView(),
            ],
          ),
        ),
      ),
    );
  }
}
