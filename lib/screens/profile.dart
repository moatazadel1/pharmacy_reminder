import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app/cubit/user_cubit.dart';
import 'package:reminder_app/cubit/user_state.dart';
import 'package:reminder_app/screens/edit_user.dart';

class PersonalProfile extends StatefulWidget {
  const PersonalProfile({super.key});

  @override
  State<PersonalProfile> createState() => _PersonalProfileState();
}

class _PersonalProfileState extends State<PersonalProfile>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // Ensure UserCubit fetches user profile when navigating to this screen
    BlocProvider.of<UserCubit>(context).getUserProfile();

    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is GetUserFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errMessage)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text("Profile",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                )),
            leading: const BackButton(color: Color(0xFF295c82)),
          ),
          body: state is GetUserLoading
              ? const Center(child: CircularProgressIndicator())
              : state is GetUserSuccess
                  ? ListView(
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 16),
                            //! Profile Picture
                            CircleAvatar(
                              radius: 80,
                              backgroundImage: NetworkImage(state.user.image),
                            ),
                            const SizedBox(height: 16),

                            //! Name
                            ListTile(
                              title: Text(state.user.name),
                              leading: const Icon(
                                Icons.person,
                                color: Color(0xFF295c82),
                                size: 25,
                              ),
                              trailing: const Icon(Icons.edit,
                                  color: Color(0xFF295c82), size: 25),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) {
                                    return UpdateProfile();
                                  }),
                                );
                              },
                            ),

                            const SizedBox(height: 16),

                            //! Email
                            ListTile(
                              title: Text(state.user.email),
                              leading: const Icon(
                                Icons.email,
                                color: Color(0xFF295c82),
                                size: 25,
                              ),
                              trailing: const Icon(Icons.edit,
                                  color: Color(0xFF295c82), size: 25),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) {
                                    return UpdateProfile();
                                  }),
                                );
                              },
                            ),
                            const SizedBox(height: 16),

                            //! password
                            ListTile(
                              title: const Text("password"),
                              leading: const Icon(
                                Icons.lock,
                                color: Color(0xFF295c82),
                                size: 25,
                              ),
                              trailing: const Icon(Icons.edit,
                                  color: Color(0xFF295c82), size: 25),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) {
                                    return UpdateProfile();
                                  }),
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ],
                    )
                  : Container(),
        );
      },
    );
  }
}
