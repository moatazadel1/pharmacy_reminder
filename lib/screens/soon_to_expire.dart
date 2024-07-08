import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app/components/soonContainer.dart';
import 'package:reminder_app/components/soonSearchfield.dart';
import 'package:reminder_app/components/soonsearch_container.dart';
import 'package:reminder_app/cubit/user_cubit.dart';
import 'package:reminder_app/cubit/user_state.dart';
import 'package:reminder_app/root_screen.dart';

class SoonToExpire extends StatefulWidget {
  const SoonToExpire({super.key});

  @override
  State<SoonToExpire> createState() => _SoonToExpireState();
}

class _SoonToExpireState extends State<SoonToExpire> {
  int index = 0;
  @override
  void initState() {
    super.initState();

    // Fetch all products when the widget is initialized
    context.read<UserCubit>().soonExpiredData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is DeleteSuccess) {
          // Navigator.pushReplacementNamed(context, RootScreen.id,
          //     arguments: BlocProvider.of<UserCubit>(context).getUserProfile());
          // const ScaffoldMessenger(child: Text('Record has been deleted'));
          BlocProvider.of<UserCubit>(context).soonExpiredData();
        }
        if (state is DeleteFailure) {
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
              "SoonToExpired",
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF295c82)),
              onPressed: () {
                Navigator.pushReplacementNamed(context, RootScreen.id,
                    arguments: BlocProvider.of<UserCubit>(context)
                        .getUserProfile()); // Navigate back to the previous screen
              },
            ),
          ),
          body: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(12),
                child: SoonSearchField(),
              ),
              Expanded(
                child: state is SoonExpiredLoading || state is SoonSearchLoading
                    ? const Center(child: CircularProgressIndicator())
                    : state is SoonExpiredSuccess
                        ? CustomScrollView(
                            slivers: [
                              SliverToBoxAdapter(
                                child: Column(
                                  children: state.soonexproducts.data.map((soonproduct) {
                                    return SoonExCustomContainer(soonexproducts: soonproduct);
                                  }).toList(),
                                ),
                              )
                            ],
                          )
                        : state is SoonSearchSuccess
                            ? state.data.items.isEmpty
                                ? const Center(
                                    child: Text(
                                      "No results found",
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : CustomScrollView(
                                    slivers: [
                                      SliverToBoxAdapter(
                                        child: Column(
                                          children: state.data.items.map((searchItem) {
                                            return SoonSearchContainer(search: searchItem);
                                          }).toList(),
                                        ),
                                      )
                                    ],
                                  )
                            : state is SoonSearchFailure
                                ? Center(
                                    child: Text(
                                      state.errmessage,
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : Container(),
              ),
            ],
          ),
        );
      },
    );
  }
}
