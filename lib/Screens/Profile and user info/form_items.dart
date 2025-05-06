import 'package:nutria/Blocs/profile_blocs/profileBloc.dart';

final labels = [
  {
    'label': 'Your height',
    'initial': (PersonalInfoLoaded state) => state.height.toString(),
    'update': (PersonalInfoCubit cubit, String val) =>
        cubit.updateHeight(int.tryParse(val) ?? 0),
  },
  {
    'label': 'Your weight',
    'initial': (PersonalInfoLoaded state) => state.weight.toString(),
    'update': (PersonalInfoCubit cubit, String val) =>
        cubit.updateWeight(int.tryParse(val) ?? 0),
  },
  {
    'label': 'Activity Level',
    'initial': (PersonalInfoLoaded state) => state.activityLevel,
    'update': (PersonalInfoCubit cubit, String val) =>
        cubit.updateActivityLevel(val),
  },
  {
    'label': 'Gender',
    'initial': (PersonalInfoLoaded state) => state.gender,
    'update': (PersonalInfoCubit cubit, String val) => cubit.updateGender(val),
  },
  {
    'label': 'Goal',
    'initial': (PersonalInfoLoaded state) => state.goal,
    'update': (PersonalInfoCubit cubit, String val) => cubit.updateGoal(val),
  },
  {
    'label': 'Birthdate',
    'initial': (PersonalInfoLoaded state) =>
        state.birthdate.toIso8601String().split('T').first, // yyyy-MM-dd
    'update': (PersonalInfoCubit cubit, String val) {
      try {
        cubit.updateBirthdate(DateTime.parse(val));
      } catch (_) {
        // optional: handle invalid date input
      }
    },
  },
];
