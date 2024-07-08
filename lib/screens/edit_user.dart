import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app/components/buttons.dart';
import 'package:reminder_app/components/textformfield.dart';
import 'package:reminder_app/cubit/user_cubit.dart';
import 'package:reminder_app/cubit/user_state.dart';
import 'package:reminder_app/screens/login.dart';
import 'package:reminder_app/widgets/pick_image_widget.dart';

class UpdateProfile extends StatelessWidget {
  UpdateProfile({super.key});

  // Use the correct GlobalKey for the FormState
  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is EditUserSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Updated successfully"),
            ),
          );
        } else if (state is EditUserFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errMessage)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: const BackButton(color: Color(0xFF295c82)),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formState, // Assign the GlobalKey to the Form widget
              child: Column(
                children: [
                  // Pick Image
                  const PickImageWidget(),
                  const SizedBox(height: 16),

                  // User Name
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: CustomTextForm(
                      hinttext: 'User Name',
                      controller: context.read<UserCubit>().updateName,
                      label: 'User Name',
                      validator: (val) {
                        if (val == '') {
                          return "Can't Be Empty";
                        }
                        return null;
                      },
                      myicon:
                          const Icon(Icons.person, color: Color(0xFF295c82)),
                    ),
                  ),

                  // Email
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: CustomTextForm(
                      hinttext: 'Email',
                      controller: context.read<UserCubit>().updateEmail,
                      label: 'Email',
                      validator: (val) {
                        if (val == '') {
                          return "Can't Be Empty";
                        }
                        return null;
                      },
                      myicon: const Icon(Icons.mail, color: Color(0xFF295c82)),
                    ),
                  ),

                  // Password
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: CustomTextForm(
                      hinttext: 'Password',
                      controller: context.read<UserCubit>().UpdatePass,
                      label: 'Password',
                      validator: (val) {
                        if (val == '') {
                          return "Can't Be Empty";
                        }
                        return null;
                      },
                      isDense: true,
                      suffixIcon: true,
                      obscureText: true,
                      myicon: const Icon(Icons.lock, color: Color(0xFF295c82)),
                    ),
                  ),

                  // Confirm Password
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: CustomTextForm(
                      hinttext: 'Confirm Password',
                      controller: context.read<UserCubit>().UpdateConfirm_pass,
                      label: 'Confirm Password',
                      validator: (val) {
                        if (val == '') {
                          return "Can't Be Empty";
                        }
                        return null;
                      },
                      isDense: true,
                      suffixIcon: true,
                      obscureText: true,
                      myicon: const Icon(Icons.lock, color: Color(0xFF295c82)),
                    ),
                  ),

                  // Update Button
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: state is EditUserLoading
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            title: "Update",
                            onPressed: () {
                              if (formState.currentState!.validate()) {
                                context.read<UserCubit>().updateProfile();
                              }
                            },
                          ),
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
