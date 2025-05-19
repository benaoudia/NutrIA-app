import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutria/Blocs/profile_blocs/profileBloc.dart';

const Color buttons_blue = Color.fromARGB(255, 103, 138, 150);

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  // Dropdown options
  static const genderOptions = ['Male', 'Female'];
  static const activityOptions = [
    'Sedentary',
    'Lightly active',
    'Moderately active',
    'Very active',
    'Extra active',
  ];
  static const goalOptions = ['Lose weight', 'Maintain weight', 'Gain weight'];
  static const List<String> countryOptions = [
    '🇦🇫 Afghanistan',
    '🇦🇱 Albania',
    '🇩🇿 Algeria',
    '🇦🇩 Andorra',
    '🇦🇴 Angola',
    '🇦🇬 Antigua & Barbuda',
    '🇦🇷 Argentina',
    '🇦🇲 Armenia',
    '🇦🇺 Australia',
    '🇦🇹 Austria',
    '🇦🇿 Azerbaijan',
    '🇧🇸 Bahamas',
    '🇧🇭 Bahrain',
    '🇧🇩 Bangladesh',
    '🇧🇧 Barbados',
    '🇧🇾 Belarus',
    '🇧🇪 Belgium',
    '🇧🇿 Belize',
    '🇧🇯 Benin',
    '🇧🇹 Bhutan',
    '🇧🇴 Bolivia',
    '🇧🇦 Bosnia & Herzegovina',
    '🇧🇼 Botswana',
    '🇧🇷 Brazil',
    '🇧🇳 Brunei',
    '🇧🇬 Bulgaria',
    '🇧🇫 Burkina Faso',
    '🇧🇮 Burundi',
    '🇨🇻 Cabo Verde',
    '🇰🇭 Cambodia',
    '🇨🇲 Cameroon',
    '🇨🇦 Canada',
    '🇨🇫 Central African Republic',
    '🇹🇩 Chad',
    '🇨🇱 Chile',
    '🇨🇳 China',
    '🇨🇴 Colombia',
    '🇰🇲 Comoros',
    '🇨🇬 Congo - Brazzaville',
    '🇨🇩 Congo - Kinshasa',
    '🇨🇷 Costa Rica',
    '🇭🇷 Croatia',
    '🇨🇺 Cuba',
    '🇨🇾 Cyprus',
    '🇨🇿 Czechia',
    '🇩🇰 Denmark',
    '🇩🇯 Djibouti',
    '🇩🇲 Dominica',
    '🇩🇴 Dominican Republic',
    '🇪🇨 Ecuador',
    '🇪🇬 Egypt',
    '🇸🇻 El Salvador',
    '🇬🇶 Equatorial Guinea',
    '🇪🇷 Eritrea',
    '🇪🇪 Estonia',
    '🇸🇿 Eswatini',
    '🇪🇹 Ethiopia',
    '🇫🇯 Fiji',
    '🇫🇮 Finland',
    '🇫🇷 France',
    '🇬🇦 Gabon',
    '🇬🇲 Gambia',
    '🇬🇪 Georgia',
    '🇩🇪 Germany',
    '🇬🇭 Ghana',
    '🇬🇷 Greece',
    '🇬🇩 Grenada',
    '🇬🇹 Guatemala',
    '🇬🇳 Guinea',
    '🇬🇼 Guinea-Bissau',
    '🇬🇾 Guyana',
    '🇭🇹 Haiti',
    '🇭🇳 Honduras',
    '🇭🇺 Hungary',
    '🇮🇸 Iceland',
    '🇮🇳 India',
    '🇮🇩 Indonesia',
    '🇮🇷 Iran',
    '🇮🇶 Iraq',
    '🇮🇪 Ireland',
    '🇮🇹 Italy',
    '🇯🇲 Jamaica',
    '🇯🇵 Japan',
    '🇯🇴 Jordan',
    '🇰🇿 Kazakhstan',
    '🇰🇪 Kenya',
    '🇰🇮 Kiribati',
    '🇰🇼 Kuwait',
    '🇰🇬 Kyrgyzstan',
    '🇱🇦 Laos',
    '🇱🇻 Latvia',
    '🇱🇧 Lebanon',
    '🇱🇸 Lesotho',
    '🇱🇷 Liberia',
    '🇱🇾 Libya',
    '🇱🇮 Liechtenstein',
    '🇱🇹 Lithuania',
    '🇱🇺 Luxembourg',
    '🇲🇬 Madagascar',
    '🇲🇼 Malawi',
    '🇲🇾 Malaysia',
    '🇲🇻 Maldives',
    '🇲🇱 Mali',
    '🇲🇹 Malta',
    '🇲🇭 Marshall Islands',
    '🇲🇷 Mauritania',
    '🇲🇺 Mauritius',
    '🇲🇽 Mexico',
    '🇫🇲 Micronesia',
    '🇲🇩 Moldova',
    '🇲🇨 Monaco',
    '🇲🇳 Mongolia',
    '🇲🇪 Montenegro',
    '🇲🇦 Morocco',
    '🇲🇿 Mozambique',
    '🇲🇲 Myanmar',
    '🇳🇦 Namibia',
    '🇳🇷 Nauru',
    '🇳🇵 Nepal',
    '🇳🇱 Netherlands',
    '🇳🇿 New Zealand',
    '🇳🇮 Nicaragua',
    '🇳🇪 Niger',
    '🇳🇬 Nigeria',
    '🇰🇵 North Korea',
    '🇲🇰 North Macedonia',
    '🇳🇴 Norway',
    '🇴🇲 Oman',
    '🇵🇰 Pakistan',
    '🇵🇼 Palau',
    '🇵🇸 Palestine',
    '🇵🇦 Panama',
    '🇵🇬 Papua New Guinea',
    '🇵🇾 Paraguay',
    '🇵🇪 Peru',
    '🇵🇭 Philippines',
    '🇵🇱 Poland',
    '🇵🇹 Portugal',
    '🇶🇦 Qatar',
    '🇷🇴 Romania',
    '🇷🇺 Russia',
    '🇷🇼 Rwanda',
    '🇰🇳 Saint Kitts & Nevis',
    '🇱🇨 Saint Lucia',
    '🇻🇨 Saint Vincent & Grenadines',
    '🇼🇸 Samoa',
    '🇸🇲 San Marino',
    '🇸🇹 Sao Tome & Principe',
    '🇸🇦 Saudi Arabia',
    '🇸🇳 Senegal',
    '🇷🇸 Serbia',
    '🇸🇨 Seychelles',
    '🇸🇱 Sierra Leone',
    '🇸🇬 Singapore',
    '🇸🇰 Slovakia',
    '🇸🇮 Slovenia',
    '🇸🇧 Solomon Islands',
    '🇸🇴 Somalia',
    '🇿🇦 South Africa',
    '🇰🇷 South Korea',
    '🇸🇸 South Sudan',
    '🇪🇸 Spain',
    '🇱🇰 Sri Lanka',
    '🇸🇩 Sudan',
    '🇸🇷 Suriname',
    '🇸🇪 Sweden',
    '🇨🇭 Switzerland',
    '🇸🇾 Syria',
    '🇹🇼 Taiwan',
    '🇹🇯 Tajikistan',
    '🇹🇿 Tanzania',
    '🇹🇭 Thailand',
    '🇹🇱 Timor-Leste',
    '🇹🇬 Togo',
    '🇹🇴 Tonga',
    '🇹🇹 Trinidad & Tobago',
    '🇹🇳 Tunisia',
    '🇹🇷 Turkey',
    '🇹🇲 Turkmenistan',
    '🇹🇻 Tuvalu',
    '🇺🇬 Uganda',
    '🇺🇦 Ukraine',
    '🇦🇪 United Arab Emirates',
    '🇬🇧 United Kingdom',
    '🇺🇸 United States',
    '🇺🇾 Uruguay',
    '🇺🇿 Uzbekistan',
    '🇻🇺 Vanuatu',
    '🇻🇦 Vatican City',
    '🇻🇪 Venezuela',
    '🇻🇳 Vietnam',
    '🇾🇪 Yemen',
    '🇿🇲 Zambia',
    '🇿🇼 Zimbabwe',
  ];

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
                height: 120,
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
                        horizontal: 24.0, vertical: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Row(
                            children: [
                              Icon(Icons.arrow_back_ios_new,
                                  color: Colors.white, size: 24),
                              SizedBox(width: 4),
                              Text('Back',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          'Edit Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Edit form
              Padding(
                padding: const EdgeInsets.only(top: 140),
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(24),
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildTextField(
                          label: 'Name',
                          value: state.name,
                          icon: Icons.person,
                          onChanged: (value) => context
                              .read<PersonalInfoCubit>()
                              .updateName(value),
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          label: 'Email',
                          value: state.email,
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) => context
                              .read<PersonalInfoCubit>()
                              .updateEmail(value),
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          label: 'Phone',
                          value: state.phone,
                          icon: Icons.phone,
                          keyboardType: TextInputType.phone,
                          onChanged: (value) => context
                              .read<PersonalInfoCubit>()
                              .updatePhone(value),
                        ),
                        const SizedBox(height: 16),
                        _buildDropdownField(
                          label: 'Country',
                          value: state.country,
                          options: countryOptions,
                          icon: Icons.flag,
                          onChanged: (value) => context
                              .read<PersonalInfoCubit>()
                              .updateCountry(value),
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          label: 'Height (cm)',
                          value: state.height.toString(),
                          icon: Icons.height,
                          keyboardType: TextInputType.number,
                          onChanged: (value) => context
                              .read<PersonalInfoCubit>()
                              .updateHeight(int.tryParse(value) ?? 0),
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          label: 'Weight (kg)',
                          value: state.weight.toString(),
                          icon: Icons.monitor_weight,
                          keyboardType: TextInputType.number,
                          onChanged: (value) => context
                              .read<PersonalInfoCubit>()
                              .updateWeight(int.tryParse(value) ?? 0),
                        ),
                        const SizedBox(height: 16),
                        _buildDropdownField(
                          label: 'Gender',
                          value: state.gender,
                          options: genderOptions,
                          icon: Icons.wc,
                          onChanged: (value) => context
                              .read<PersonalInfoCubit>()
                              .updateGender(value),
                        ),
                        const SizedBox(height: 16),
                        _buildDropdownField(
                          label: 'Activity Level',
                          value: state.activityLevel,
                          options: activityOptions,
                          icon: Icons.directions_run,
                          onChanged: (value) => context
                              .read<PersonalInfoCubit>()
                              .updateActivityLevel(value),
                        ),
                        const SizedBox(height: 16),
                        _buildDropdownField(
                          label: 'Goal',
                          value: state.goal,
                          options: goalOptions,
                          icon: Icons.flag_circle,
                          onChanged: (value) => context
                              .read<PersonalInfoCubit>()
                              .updateGoal(value),
                        ),
                        const SizedBox(height: 16),
                        _buildDateField(
                          context: context,
                          label: 'Birthdate',
                          value: state.birthdate,
                          icon: Icons.cake,
                          onChanged: (value) => context
                              .read<PersonalInfoCubit>()
                              .updateBirthdate(value),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttons_blue,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            context.read<PersonalInfoCubit>().submitForm();
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Save Changes',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String value,
    required IconData icon,
    required Function(String) onChanged,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      initialValue: value,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: buttons_blue),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: buttons_blue, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
        labelStyle: TextStyle(color: Colors.grey[700]),
      ),
      onChanged: onChanged,
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> options,
    required IconData icon,
    required Function(String) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: options.contains(value) ? value : null,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: buttons_blue),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: buttons_blue, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
        labelStyle: TextStyle(color: Colors.grey[700]),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      dropdownColor: Colors.white,
      iconEnabledColor: buttons_blue,
      isExpanded: true,
      items: options
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14),
                ),
              ))
          .toList(),
      onChanged: (val) {
        if (val != null) onChanged(val);
      },
    );
  }

  Widget _buildDateField({
    required BuildContext context,
    required String label,
    required DateTime value,
    required IconData icon,
    required Function(DateTime) onChanged,
  }) {
    final controller =
        TextEditingController(text: value.toString().split(' ')[0]);
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: buttons_blue),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: buttons_blue, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
        labelStyle: TextStyle(color: Colors.grey[700]),
      ),
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: value,
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: buttons_blue,
                  onPrimary: Colors.white,
                  onSurface: Colors.black,
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) {
          controller.text = picked.toString().split(' ')[0];
          onChanged(picked);
        }
      },
    );
  }
}
