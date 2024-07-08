import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app/components/buttons.dart';
import 'package:reminder_app/components/textformfield.dart';
import 'package:reminder_app/cubit/user_cubit.dart';
import 'package:reminder_app/cubit/user_state.dart';
import 'package:reminder_app/screens/dashboard.dart';
import '../core/utils/validators.dart';

class CreateAdmin extends StatefulWidget {
  const CreateAdmin({super.key});
  static String id = 'CreateAdmin';
  @override
  State<CreateAdmin> createState() => _CreateAdminState();
}

class _CreateAdminState extends State<CreateAdmin> {
  @override
  int index = 0;

  GlobalKey<FormState> adminSignInFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is AdminSignInSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('success'),
            ),
          );
          Navigator.pushReplacementNamed(context, Dashboard.id);
        } else if (state is AdminSignInFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errmessage)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 244, 243, 243),
            title: const Text(
              "Admin",
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            leading: const BackButton(color: Color(0xFF5DADEC)),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: adminSignInFormKey,
              child: Column(
                children: [
                  const Center(
                    child: Image(
                      image: AssetImage("images/createAdmin.png"),
                      height: 200,
                      width: 200,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomTextForm(
                      validator: (p0) {
                        return Validators.emailValidator(p0);
                      },
                      hinttext: 'Email',
                      controller: context.read<UserCubit>().adminSignInEmail,
                      label: 'Email',
                      myicon: const Icon(Icons.mail, color: Color(0xFF295c82)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomTextForm(
                      validator: (p0) {
                        return Validators.passwordValidator(p0);
                      },
                      hinttext: 'Password',
                      controller: context.read<UserCubit>().adminSignInPassword,
                      label: 'Password',
                      isDense: true,
                      obscureText: true,
                      suffixIcon: true,
                      myicon: const Icon(Icons.lock, color: Color(0xFF295c82)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: state is AddItemLoading
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            title: "Login",
                            onPressed: () {
                              if (adminSignInFormKey.currentState!.validate()) {
                                context.read<UserCubit>().adminsignIn();
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
