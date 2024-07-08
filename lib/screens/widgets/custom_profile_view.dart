import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/user_cubit.dart';
import '../../cubit/user_state.dart';
import '../profile.dart';

class CustomProfileView extends StatelessWidget {
  const CustomProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      buildWhen: (previous, current) =>
          current is GetUserLoading ||
          current is GetUserSuccess ||
          current is GetUserFailure,
      builder: (context, state) {
        if (state is GetUserLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetUserSuccess) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const PersonalProfile();
                  },
                ),
              );
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 15, right: 3),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(state.user.image),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 10, right: 60),
                  child: Text(
                    state.user.name,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30, left: 60),
                  child: Icon(
                    Icons.person,
                    color: Colors.grey,
                    size: 35,
                  ),
                ),
              ],
            ),
          );
        } else if (state is GetUserFailure) {
          return Text(state.errMessage);
        } else {
          return const Center(
              child: SizedBox(
            height: 90,
          ));
        }
      },
    );
  }
}
