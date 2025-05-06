
import 'package:nutria/Blocs/profile_blocs/profileBloc.dart';

final labels = [
  {
    'label': 'Your name',
    'initial': (PersonalInfoLoaded state) => state.name.toString(),
    'update': (PersonalInfoCubit cubit, String val) =>
        cubit.updateName(val),
  },
  {
    'label': 'Your phone number',
    'initial': (PersonalInfoLoaded state) => state.phone,
    'update': (PersonalInfoCubit cubit, String val) =>
        cubit.updatePhone(val), // Updated for phone number handling
  },
  {
    'label': 'Your email',
    'initial': (PersonalInfoLoaded state) => state.email,
    'update': (PersonalInfoCubit cubit, String val) =>
        cubit.updateEmail(val),
  },
  {
    'label': 'Your country',
    'initial': (PersonalInfoLoaded state) => state.country,
    'update': (PersonalInfoCubit cubit, String val) =>
        cubit.updateCountry(val),
  },
];
