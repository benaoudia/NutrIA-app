import 'package:equatable/equatable.dart';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PersonalInfoState extends Equatable {
  PersonalInfoState();

  @override
  List<Object?> get props => [];
}

class PersonalInfoInitial extends PersonalInfoState {}

class PersonalInfoLoading extends PersonalInfoState {}

class PersonalInfoLoaded extends PersonalInfoState {
  final String name;
  final String email;
  final String phone;
  final String country;
  final int height;
  final int weight;
  final String activityLevel;
  final String gender;
  final List allergies;
  final String goal;
  final DateTime birthdate;
  final bool isFormValid;
  final int step;

  PersonalInfoLoaded({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.country = '',
    this.height = 0,
    this.weight = 0,
    this.activityLevel = '',
    this.gender = '',
    this.allergies = const [],
    this.goal = '',
    DateTime? birthdate,
    this.isFormValid = false,
    this.step = 0,
  }) : birthdate = birthdate ?? DateTime.utc(2000, 1, 1);

  PersonalInfoLoaded copyWith({
    String? email,
    String? phone,
    String? country,
    String? name,
    int? height,
    int? weight,
    String? activityLevel,
    String? gender,
    List? allergies,
    String? goal,
    DateTime? birthdate,
    bool? isFormValid,
    int? step,
  }) {
    return PersonalInfoLoaded(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      country: country ?? this.country,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      activityLevel: activityLevel ?? this.activityLevel,
      gender: gender ?? this.gender,
      allergies: allergies ?? this.allergies,
      goal: goal ?? this.goal,
      birthdate: birthdate ?? this.birthdate,
      isFormValid: isFormValid ?? this.isFormValid,
      step: step ?? this.step,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'country': country,
      'height': height,
      'weight': weight,
      'activityLevel': activityLevel,
      'gender': gender,
      'allergies': allergies,
      'goal': goal,
      'birthdate': birthdate.toIso8601String(),
      'step': step,
    };
  }

  @override
  List<Object?> get props => [
    name,
    email,
    phone,
    country,
    height,
    weight,
    activityLevel,
    gender,
    allergies,
    goal,
    birthdate,
    isFormValid,
    step,
  ];
}

class PersonalInfoError extends PersonalInfoState {
  final String errorMessage;

  PersonalInfoError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class PersonalInfoCubit extends Cubit<PersonalInfoState> {
  PersonalInfoCubit() : super(PersonalInfoInitial());

  void initForm() {
    emit(PersonalInfoLoaded());
  }

  void updateName(String name) {
    if (state is PersonalInfoLoaded) {
      final currentState = state as PersonalInfoLoaded;
      emit(currentState.copyWith(
        name: name,
      ));
    }
  }

  void updateEmail(String email) {
    if (state is PersonalInfoLoaded) {
      final currentState = state as PersonalInfoLoaded;
      emit(currentState.copyWith(
        email: email,
      ));
    }
  }

  void updatePhone(String phone) {
    if (state is PersonalInfoLoaded) {
      final currentState = state as PersonalInfoLoaded;
      emit(currentState.copyWith(
        phone: phone,
      ));
    }
  }

  void updateCountry(String country) {
    if (state is PersonalInfoLoaded) {
      final currentState = state as PersonalInfoLoaded;
      emit(currentState.copyWith(
        country: country,
        isFormValid: _validateForm(
          name: currentState.name,
          email: currentState.email,
          country: country,
          height: currentState.height,
          weight: currentState.weight,
          activityLevel: currentState.activityLevel,
          gender: currentState.gender,
          goal: currentState.goal,
          birthdate: currentState.birthdate,
          phone: currentState.phone,
        ),
      ));
    }
  }

  void updateHeight(int height) {
    if (state is PersonalInfoLoaded) {
      final currentState = state as PersonalInfoLoaded;
      emit(currentState.copyWith(
        height: height,
      ));
    }
  }

  void updateWeight(int weight) {
    if (state is PersonalInfoLoaded) {
      final currentState = state as PersonalInfoLoaded;
      emit(currentState.copyWith(
        weight: weight,
      ));
    }
  }

  void updateActivityLevel(String activityLevel) {
    if (state is PersonalInfoLoaded) {
      final currentState = state as PersonalInfoLoaded;
      emit(currentState.copyWith(
        activityLevel: activityLevel,
        isFormValid: _validateForm(
          name: currentState.name,
          email: currentState.email,
          country: currentState.country,
          height: currentState.height,
          weight: currentState.weight,
          activityLevel: activityLevel,
          gender: currentState.gender,
          goal: currentState.goal,
          birthdate: currentState.birthdate,
          phone: currentState.phone,
        ),
      ));
    }
  }

  void updateGender(String gender) {
    if (state is PersonalInfoLoaded) {
      final currentState = state as PersonalInfoLoaded;
      emit(currentState.copyWith(
        gender: gender,
        isFormValid: _validateForm(
          name: currentState.name,
          email: currentState.email,
          country: currentState.country,
          height: currentState.height,
          weight: currentState.weight,
          activityLevel: currentState.activityLevel,
          gender: gender,
          goal: currentState.goal,
          birthdate: currentState.birthdate,
          phone: currentState.phone,
        ),
      ));
    }
  }

  void updateAllergies(List allergies) {
    if (state is PersonalInfoLoaded) {
      final currentState = state as PersonalInfoLoaded;
      emit(currentState.copyWith(
        allergies: allergies,
        isFormValid: _validateForm(
          name: currentState.name,
          email: currentState.email,
          country: currentState.country,
          height: currentState.height,
          weight: currentState.weight,
          activityLevel: currentState.activityLevel,
          gender: currentState.gender,
          goal: currentState.goal,
          birthdate: currentState.birthdate,
          phone: currentState.phone,
        ),
      ));
    }
  }

  void updateGoal(String goal) {
    if (state is PersonalInfoLoaded) {
      final currentState = state as PersonalInfoLoaded;
      emit(currentState.copyWith(
        goal: goal,
        isFormValid: _validateForm(
          name: currentState.name,
          email: currentState.email,
          country: currentState.country,
          height: currentState.height,
          weight: currentState.weight,
          activityLevel: currentState.activityLevel,
          gender: currentState.gender,
          goal: goal,
          birthdate: currentState.birthdate,
          phone: currentState.phone,
        ),
      ));
    }
  }

  void updateBirthdate(DateTime birthdate) {
    if (state is PersonalInfoLoaded) {
      final currentState = state as PersonalInfoLoaded;
      emit(currentState.copyWith(
        birthdate: birthdate,
        isFormValid: _validateForm(
          name: currentState.name,
          email: currentState.email,
          country: currentState.country,
          height: currentState.height,
          weight: currentState.weight,
          activityLevel: currentState.activityLevel,
          gender: currentState.gender,
          goal: currentState.goal,
          birthdate: birthdate,
          phone: currentState.phone,
        ),
      ));
    }
  }

  bool _validateForm({
    required String name,
    required String email,
    required String country,
    required int height,
    required int weight,
    required String activityLevel,
    required String gender,
    required String goal,
    required DateTime birthdate,
    required String phone,
  }) {
    bool isNameValid = name.trim().isNotEmpty;
    bool isEmailValid = email.trim().isNotEmpty && email.contains('@');
    bool isCountryValid = country.trim().isNotEmpty;
    bool isHeightValid = height > 0;
    bool isWeightValid = weight > 0;
    bool isActivityLevelValid = activityLevel.trim().isNotEmpty;
    bool isGenderValid = gender.trim().isNotEmpty;
    bool isGoalValid = goal.trim().isNotEmpty;
    bool isPhoneValid = phone.trim().length >= 10;  // Example: validate phone length

    final now = DateTime.now();
    final age = now.year - birthdate.year - (now.month > birthdate.month || (now.month == birthdate.month && now.day >= birthdate.day) ? 0 : 1);
    bool isAgeValid = age >= 10;

    return isNameValid && isEmailValid && isCountryValid && isHeightValid && isWeightValid && isActivityLevelValid && isGenderValid && isGoalValid && isPhoneValid && isAgeValid;
  }

  bool validateForm() {
    if (state is PersonalInfoLoaded) {
      final currentState = state as PersonalInfoLoaded;
      final isValid = _validateForm(
        name: currentState.name,
        email: currentState.email,
        country: currentState.country,
        height: currentState.height,
        weight: currentState.weight,
        activityLevel: currentState.activityLevel,
        gender: currentState.gender,
        goal: currentState.goal,
        birthdate: currentState.birthdate,
        phone: currentState.phone,
      );
      
      emit(currentState.copyWith(isFormValid: isValid));
      return isValid;
    }
    return false;
  }

  void submitForm() async {
    if (state is PersonalInfoLoaded) {
      final currentState = state as PersonalInfoLoaded;
      
      if (!validateForm()) {
        emit(PersonalInfoError('Please fill in all required fields correctly.'));
        return;
      }
      
      try {
        emit(PersonalInfoLoading());
        await Future.delayed(const Duration(seconds: 1));
        emit(currentState);
      } catch (e) {
        emit(PersonalInfoError('Failed to submit form: ${e.toString()}'));
      }
    }
  }

  void goToStep(int step) {
    if (state is PersonalInfoLoaded) {
      final currentState = state as PersonalInfoLoaded;
      emit(currentState.copyWith(step: step));
    }
  }
}
