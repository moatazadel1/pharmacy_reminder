import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app/components/buttons.dart';
import 'package:reminder_app/components/textformfield.dart';
import 'package:reminder_app/core/utils/validators.dart';
import 'package:reminder_app/cubit/user_cubit.dart';
import 'package:reminder_app/cubit/user_state.dart';
import 'package:reminder_app/root_screen.dart';
import 'package:reminder_app/screens/reset_password.dart';
import 'package:reminder_app/screens/sign_up.dart';
import 'package:reminder_app/widgets/startup.dart';

import '../core/utils/app_methods.dart';

class LogIn extends StatelessWidget {
  LogIn({super.key});
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> signInFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login successful'),
            ),
          );
          context.read<UserCubit>().getUserProfile();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) {
              return const RootScreen();
            }),
          );
        } else if (state is SignInFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errmessage)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.5,
            automaticallyImplyLeading: false,
            leading: BackButton(
              color: const Color(0xFF295c82),
              onPressed: () {
                Navigator.of(context).pushNamed(StartUp.id);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: signInFormKey,
              child: Column(children: [
                const Center(
                  child: Image(
                    image: AssetImage("images/log_in.png"),
                    height: 250,
                    width: 250,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTextForm(
                    validator: (p0) {
                      return Validators.emailValidator(p0);
                    },
                    hinttext: 'Email',
                    controller: context.read<UserCubit>().signInEmail,
                    label: 'Email',
                    myicon: const Icon(Icons.mail, color: Color(0xFF295c82)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: CustomTextForm(
                    validator: (p0) {
                      return Validators.passwordValidator(p0);
                    },
                    hinttext: 'Password',
                    controller: context.read<UserCubit>().signInPassword,
                    label: 'Password',
                    isDense: true,
                    obscureText: true,
                    suffixIcon: true,
                    myicon: const Icon(Icons.lock, color: Color(0xFF295c82)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 175, top: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const ResetPassword();
                      }));
                    },
                    child: const Text(
                      "Forget Password?",
                      style: TextStyle(color: Color(0xFF295c82), fontSize: 19),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: state is SignInLoading
                      ? const CircularProgressIndicator()
                      : CustomButton(
                          title: "Login",
                          onPressed: () {
                            if (signInFormKey.currentState!.validate()) {
                              context.read<UserCubit>().signIn();
                            }
                          },
                        ),
                ),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Color(0xFF7f8184),
                        thickness: 2,
                        indent: 30,
                        endIndent: 10,
                        height: 25,
                      ),
                    ),
                    Text("Or Login With:",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF7f8184),
                            fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Divider(
                        color: Color(0xFF7f8184),
                        thickness: 2,
                        indent: 10,
                        endIndent: 30,
                        height: 25,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        await AppMethods.goolgeSignIn(context: context);
                      },
                      child: const Image(
                        image: AssetImage("images/google.png"),
                        height: 50,
                        width: 50,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(30),
                      child: InkWell(
                        child: Image(
                          image: AssetImage("images/apple.png"),
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ),
                    const InkWell(
                      child: Image(
                        image: AssetImage("images/facebook.png"),
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't Have an Account?"),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return SignUP();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        "SignUp",
                        style:
                            TextStyle(color: Color(0xFF295c82), fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}
