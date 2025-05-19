import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutria/Blocs/profile_blocs/profileBloc.dart';
import 'package:nutria/Screens/Profile and user info/ProfileEditScreenBuilder.dart';
import 'package:nutria/Screens/Profile and user info/PasswordChangeScreenBuilder.dart';

const Color buttons_blue = Color.fromARGB(255, 103, 138, 150);

class ProfileDisplayScreen extends StatefulWidget {
  const ProfileDisplayScreen({super.key});

  @override
  State<ProfileDisplayScreen> createState() => _ProfileDisplayScreenState();
}

class _ProfileDisplayScreenState extends State<ProfileDisplayScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Initial data load
    context.read<PersonalInfoCubit>().refreshData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Refresh data when app comes back to foreground
      context.read<PersonalInfoCubit>().refreshData();
    }
  }

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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 24.0),
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
                          child: const Icon(Icons.person,
                              color: Colors.white, size: 32),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.name.isEmpty ? 'Your Profile' : state.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            SizedBox(
                              width: 180, // Adjust width as needed
                              child: Text(
                                state.email,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                                maxLines: 2,
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
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 16,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Edit and Password buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton.icon(
                                  onPressed: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ProfileEditScreenBuilder(),
                                      ),
                                    );
                                    // Refresh data after returning from edit screen
                                    if (mounted) {
                                      context
                                          .read<PersonalInfoCubit>()
                                          .refreshData();
                                    }
                                  },
                                  icon: const Icon(Icons.edit,
                                      color: buttons_blue, size: 18),
                                  label: const Text('Edit Profile',
                                      style: TextStyle(color: buttons_blue)),
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                TextButton.icon(
                                  onPressed: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const PasswordChangeScreenBuilder(),
                                      ),
                                    );
                                    // Refresh data after returning from password screen
                                    if (mounted) {
                                      context
                                          .read<PersonalInfoCubit>()
                                          .refreshData();
                                    }
                                  },
                                  icon: const Icon(Icons.lock,
                                      color: buttons_blue, size: 18),
                                  label: const Text('Change Password',
                                      style: TextStyle(color: buttons_blue)),
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            // Personal Information Section
                            _buildSection(
                              'Personal Information',
                              [
                                _buildInfoRow('Name', state.name),
                                _buildInfoRow('Email', state.email),
                                _buildInfoRow('Phone', state.phone),
                                _buildInfoRow('Country', state.country),
                                _buildInfoRow('Birthdate',
                                    state.birthdate.toString().split(' ')[0]),
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
                                _buildInfoRow(
                                    'Activity Level', state.activityLevel),
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
