import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutria/Blocs/profile_blocs/profileBloc.dart';
import 'package:nutria/Screens/Profile%20and%20user%20info/PersonalInfoScreen.dart';

class PersonalInfoBuilder extends StatelessWidget {
  const PersonalInfoBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PersonalInfoCubit>(
      create: (context) => PersonalInfoCubit()..initForm(),
      child: PersonalInfo(),

    );
  }
}