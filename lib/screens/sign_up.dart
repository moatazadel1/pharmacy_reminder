import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app/components/buttons.dart';
import 'package:reminder_app/components/textformfield.dart';
import 'package:reminder_app/core/utils/validators.dart';
import 'package:reminder_app/cubit/user_cubit.dart';
import 'package:reminder_app/cubit/user_state.dart';
import 'package:reminder_app/screens/login.dart';
import 'package:reminder_app/widgets/pick_image_widget.dart';

class SignUP extends StatelessWidget {
  SignUP({super.key});
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> signUpFormKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) async {
        if (state is SignUpSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Success'),
            ),
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) {
              return LogIn();
            }),
          );
        } else if (state is SignUpFailure) {
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
              key: signUpFormKey,
              child: Column(
                children: [
                  const PickImageWidget(),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: CustomTextForm(
                      hinttext: 'User Name',
                      controller: context.read<UserCubit>().signUpName,
                      label: 'User Name',
                      validator: (p0) {
                        return Validators.displayNamevalidator(p0);
                      },
                      myicon:
                          const Icon(Icons.person, color: Color(0xFF295c82)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: CustomTextForm(
                      hinttext: 'Email',
                      controller: context.read<UserCubit>().signUpEmail,
                      label: 'Email',
                      validator: (p0) {
                        return Validators.emailValidator(p0);
                      },
                      myicon: const Icon(Icons.mail, color: Color(0xFF295c82)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: CustomTextForm(
                      hinttext: 'Password',
                      controller: context.read<UserCubit>().signUpPassword,
                      label: 'Password',
                      validator: (p0) {
                        return Validators.passwordValidator(p0);
                      },
                      isDense: true,
                      suffixIcon: true,
                      obscureText: true,
                      myicon: const Icon(Icons.lock, color: Color(0xFF295c82)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: CustomTextForm(
                      hinttext: 'Confirm Password',
                      controller: context.read<UserCubit>().confirmPassword,
                      label: 'Confirm Password',
                      // validator: (p0) {
                      //   return Validators.repeatPasswordValidator(
                      //       value: p0, password: password.text);
                      // },
                      isDense: true,
                      suffixIcon: true,
                      obscureText: true,
                      myicon: const Icon(Icons.lock, color: Color(0xFF295c82)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: state is SignUpLoading
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            title: "Create Acount",
                            onPressed: () {
                              if (signUpFormKey.currentState!.validate()) {
                                context.read<UserCubit>().signUp();
                              }
                            },
                          ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already Have an Account..."),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return LogIn();
                          }));
                        },
                        child: const Text(
                          "LogIn",
                          style:
                              TextStyle(color: Color(0xFF295c82), fontSize: 15),
                        ),
                      ),
                    ],
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
