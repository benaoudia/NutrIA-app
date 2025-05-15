import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutria/Blocs/profile_blocs/profileBloc.dart';
import 'package:nutria/Screens/Profile and user info/ProfileDisplayScreen.dart';

class ProfileDisplayScreenBuilder extends StatelessWidget {
  const ProfileDisplayScreenBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PersonalInfoCubit>(
      create: (context) => PersonalInfoCubit()..initForm(),
      child: const ProfileDisplayScreen(),
    );
  }
} 