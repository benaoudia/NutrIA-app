import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutria/Blocs/profile_blocs/profileBloc.dart';
import 'package:nutria/Screens/Profile and user info/ProfileEditScreenBuilder.dart';
import 'package:nutria/Screens/Profile and user info/PasswordChangeScreenBuilder.dart';

const Color buttons_blue = Color.fromARGB(255, 103, 138, 150);

class RecommendationQuestionnaryScreen extends StatelessWidget {
  const RecommendationQuestionnaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: BlocBuilder<PersonalInfoCubit, PersonalInfoState>(
        builder: (context, state) {
          if (state is! PersonalInfoLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
            children: [
              // Header background
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  color: buttons_blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile icon
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.person, color: Colors.white, size: 32),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Recommendation questionary",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              state.email,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Profile content
              Padding(
                padding: const EdgeInsets.only(top: 140),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Profile card
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 16,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 24),
                            // Personal Information Section
                            _buildSection(
                              'Meal information',
                              [
                                _buildInfoRow('Meal type', state.name),
                                _buildInfoRow('Time', state.email),
                                _buildInfoRow('Cooking skills', state.phone),
                                _buildInfoRow('Flavor', state.country),
                                _buildInfoRow('Spicy level', state.birthdate.toString().split(' ')[0]),
                                _buildInfoRow('number of meals', state.birthdate.toString().split(' ')[0]),
                              ],
                            ),
                            const SizedBox(height: 24),
                            // Physical Information Section
                            _buildSection(
                              'Physical Information',
                              [
                                _buildInfoRow('Height', '${state.height} cm'),
                                _buildInfoRow('Weight', '${state.weight} kg'),
                                _buildInfoRow('Gender', state.gender),
                                _buildInfoRow('Activity Level', state.activityLevel),
                              ],
                            ),
                            const SizedBox(height: 24),
                            // Goals Section
                            _buildSection(
                              'Goals & Preferences',
                              [
                                _buildInfoRow('Goal', state.goal),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: buttons_blue,
          ),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 