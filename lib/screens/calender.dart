import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app/components/calender_container.dart';
import 'package:reminder_app/cubit/user_cubit.dart';
import 'package:reminder_app/cubit/user_state.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  int index = 1;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is SearchCalenderFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errmessage)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            // leading: const BackButton(color: Color(0xFF295c82)),
            title: const Text(
              "Calender",
            ),
          ),
          body: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const Center(
                    child: Image(
                      image: AssetImage("images/date.png"),
                      height: 250,
                      width: 250,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "you can check the products you entered on a specific date.",
                      style: TextStyle(color: Color(0xFF295c82), fontSize: 19),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    width: 400,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: context.read<UserCubit>().searchCalender,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.calendar_today),
                          labelText: "Enter The ProDate... ",
                          prefixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              context.read<UserCubit>().calendersearch();
                            },
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              context.read<UserCubit>().clearcalender();
                            },
                          ),
                        ),
                        onTap: () async {
                          DateTime? pickeddate1 = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100));
                          if (pickeddate1 != null) {
                            setState(() {
                              context.read<UserCubit>().searchCalender.text =
                                  pickeddate1.toString().split(" ")[0];
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  if (state is SearchCalenderLoading)
                    const Center(child: CircularProgressIndicator()),
                  if (state is SearchCalenderSuccess)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.data.items.length,
                      itemBuilder: (context, index) {
                        return CalenderContainer(
                            search: state.data.items[index]);
                      },
                    ),
                  if (state is SearchCalenderFailure)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('No Results Found!'),
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
