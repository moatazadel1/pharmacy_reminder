import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app/cubit/user_cubit.dart';


class HomeSearchField extends StatelessWidget {
  const HomeSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // controller: context.read<UserCubit>().searchController,
      decoration: InputDecoration(
        labelText: 'Search....',
        hintText: 'Search',
        prefixIcon: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF295c82)),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
