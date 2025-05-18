import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutria/Blocs/profile_blocs/profileBloc.dart';
import 'package:nutria/Screens/Profile and user info/personalInfoitems.dart'
    as personal_info;
import 'package:nutria/Screens/Profile and user info/form_items.dart'
    as form_info;

const Color buttons_blue = Color.fromARGB(255, 103, 138, 150);

// List of all countries with emoji flags
const List<String> countryOptions = [
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

// Helper for dropdown fields
Widget buildDropdownField({
  required String label,
  required String value,
  required List<String> options,
  required void Function(String) onChanged,
  required IconData icon,
}) {
  return DropdownButtonFormField<String>(
    value: options.contains(value) ? value : null,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: buttons_blue),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: buttons_blue, width: 2),
      ),
      filled: true,
      fillColor: Colors.white,
      labelStyle: TextStyle(color: Colors.grey[700]),
    ),
    dropdownColor: Colors.white,
    iconEnabledColor: buttons_blue,
    items:
        options.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
    onChanged: (val) {
      if (val != null) onChanged(val);
    },
  );
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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

  // Icon mapping
  static const Map<String, IconData> fieldIcons = {
    'Your name': Icons.person,
    'Your phone number': Icons.phone,
    'Your email': Icons.email,
    'Your country': Icons.flag,
    'Your height': Icons.height,
    'Your weight': Icons.monitor_weight,
    'Activity Level': Icons.directions_run,
    'Gender': Icons.wc,
    'Goal': Icons.flag_circle,
    'Birthdate': Icons.cake,
  };

  TextInputType getKeyboardType(String label) {
    switch (label) {
      case 'Your phone number':
        return TextInputType.phone;
      case 'Your height':
      case 'Your weight':
        return TextInputType.number;
      case 'Your email':
        return TextInputType.emailAddress;
      default:
        return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.grey,
          selectionColor: Colors.grey[300],
          selectionHandleColor: Colors.grey[700],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: BlocBuilder<PersonalInfoCubit, PersonalInfoState>(
          builder: (context, state) {
            if (state is! PersonalInfoLoaded) {
              return const Center(child: CircularProgressIndicator());
            }
            final step = state.step;
            final items = step == 0 ? personal_info.labels : form_info.labels;
            return Stack(
              children: [
                // Header background
                if (step == 0)
                  Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 103, 138, 150),
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
                            // Nutrition icon (e.g., apple)
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.local_dining,
                                  color: Colors.white, size: 32),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Welcome to NutrIA!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Let's get to know you!",
                                  style: TextStyle(
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
                // Form card
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: step == 0 ? 140 : 0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          if (step == 0)
                            Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                // Card
                                Container(
                                  margin: const EdgeInsets.only(top: 40),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 32),
                                  width: 380,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(32),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 16,
                                        offset: Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      const SizedBox(height: 40),
                                      // Step indicator
                                      Text(
                                        'Step 1/2',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: buttons_blue,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 16),
                                      // Form fields
                                      ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: items.length,
                                        separatorBuilder: (_, __) =>
                                            const SizedBox(height: 14),
                                        itemBuilder: (context, index) {
                                          final item = items[index];
                                          final label = item['label'] as String;
                                          final initial = (item['initial']
                                              as dynamic Function(
                                                  PersonalInfoLoaded))(state);
                                          final icon =
                                              fieldIcons[label] ?? Icons.info;

                                          // Dropdown fields
                                          if (label == 'Gender') {
                                            return DropdownButtonFormField<
                                                String>(
                                              value: genderOptions
                                                      .contains(initial)
                                                  ? initial
                                                  : null,
                                              decoration: InputDecoration(
                                                labelText: label,
                                                prefixIcon: Icon(icon,
                                                    color: buttons_blue),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  borderSide: BorderSide(
                                                      color: buttons_blue,
                                                      width: 2),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                                labelStyle: TextStyle(
                                                    color: Colors.grey[700]),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 8),
                                              ),
                                              dropdownColor: Colors.white,
                                              iconEnabledColor: buttons_blue,
                                              items: genderOptions
                                                  .map((e) => DropdownMenuItem(
                                                      value: e, child: Text(e)))
                                                  .toList(),
                                              onChanged: (val) {
                                                if (val != null)
                                                  (item['update']
                                                          as dynamic Function(
                                                              PersonalInfoCubit,
                                                              String))(
                                                      context.read<
                                                          PersonalInfoCubit>(),
                                                      val);
                                              },
                                            );
                                          } else if (label ==
                                              'Activity Level') {
                                            return DropdownButtonFormField<
                                                String>(
                                              value: activityOptions
                                                      .contains(initial)
                                                  ? initial
                                                  : null,
                                              decoration: InputDecoration(
                                                labelText: label,
                                                prefixIcon: Icon(icon,
                                                    color: buttons_blue),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  borderSide: BorderSide(
                                                      color: buttons_blue,
                                                      width: 2),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                                labelStyle: TextStyle(
                                                    color: Colors.grey[700]),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 8),
                                              ),
                                              dropdownColor: Colors.white,
                                              iconEnabledColor: buttons_blue,
                                              items: activityOptions
                                                  .map((e) => DropdownMenuItem(
                                                      value: e, child: Text(e)))
                                                  .toList(),
                                              onChanged: (val) {
                                                if (val != null)
                                                  (item['update']
                                                          as dynamic Function(
                                                              PersonalInfoCubit,
                                                              String))(
                                                      context.read<
                                                          PersonalInfoCubit>(),
                                                      val);
                                              },
                                            );
                                          } else if (label == 'Goal') {
                                            return DropdownButtonFormField<
                                                String>(
                                              value:
                                                  goalOptions.contains(initial)
                                                      ? initial
                                                      : null,
                                              decoration: InputDecoration(
                                                labelText: label,
                                                prefixIcon: Icon(icon,
                                                    color: buttons_blue),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  borderSide: BorderSide(
                                                      color: buttons_blue,
                                                      width: 2),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                                labelStyle: TextStyle(
                                                    color: Colors.grey[700]),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 8),
                                              ),
                                              dropdownColor: Colors.white,
                                              iconEnabledColor: buttons_blue,
                                              items: goalOptions
                                                  .map((e) => DropdownMenuItem(
                                                      value: e, child: Text(e)))
                                                  .toList(),
                                              onChanged: (val) {
                                                if (val != null)
                                                  (item['update']
                                                          as dynamic Function(
                                                              PersonalInfoCubit,
                                                              String))(
                                                      context.read<
                                                          PersonalInfoCubit>(),
                                                      val);
                                              },
                                            );
                                          } else if (label == 'Your country') {
                                            return DropdownButtonFormField<
                                                String>(
                                              value: countryOptions
                                                      .contains(initial)
                                                  ? initial
                                                  : null,
                                              decoration: InputDecoration(
                                                labelText: label,
                                                prefixIcon: Icon(icon,
                                                    color: buttons_blue),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  borderSide: BorderSide(
                                                      color: buttons_blue,
                                                      width: 2),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                                labelStyle: TextStyle(
                                                    color: Colors.grey[700]),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 8),
                                              ),
                                              dropdownColor: Colors.white,
                                              iconEnabledColor: buttons_blue,
                                              items: countryOptions
                                                  .map((e) => DropdownMenuItem(
                                                      value: e, child: Text(e)))
                                                  .toList(),
                                              onChanged: (val) {
                                                if (val != null)
                                                  (item['update']
                                                          as dynamic Function(
                                                              PersonalInfoCubit,
                                                              String))(
                                                      context.read<
                                                          PersonalInfoCubit>(),
                                                      val);
                                              },
                                            );
                                          }

                                          // Date field
                                          if (label == 'Birthdate') {
                                            final controller =
                                                TextEditingController(
                                                    text: initial ?? '');
                                            final focusNode = FocusNode();
                                            return TextFormField(
                                              controller: controller,
                                              focusNode: focusNode,
                                              readOnly: true,
                                              cursorColor: Colors.grey[700],
                                              decoration: InputDecoration(
                                                labelText: label,
                                                prefixIcon: Icon(icon,
                                                    color: buttons_blue),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  borderSide: BorderSide(
                                                      color: buttons_blue,
                                                      width: 2),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                                labelStyle: TextStyle(
                                                    color: Colors.grey[700]),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 8),
                                              ),
                                              onTap: () async {
                                                controller.selection =
                                                    TextSelection(
                                                        baseOffset: 0,
                                                        extentOffset: controller
                                                            .text.length);
                                                DateTime? picked =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate:
                                                      DateTime.tryParse(
                                                              initial) ??
                                                          DateTime(2000),
                                                  firstDate: DateTime(1900),
                                                  lastDate: DateTime.now(),
                                                  builder: (context, child) {
                                                    return Theme(
                                                      data: Theme.of(context)
                                                          .copyWith(
                                                        colorScheme:
                                                            ColorScheme.light(
                                                          primary: buttons_blue,
                                                          onPrimary:
                                                              Colors.white,
                                                          onSurface:
                                                              Colors.black,
                                                        ),
                                                      ),
                                                      child: child!,
                                                    );
                                                  },
                                                );
                                                (item['update']
                                                    as dynamic Function(
                                                        PersonalInfoCubit,
                                                        String))(
                                                  context.read<
                                                      PersonalInfoCubit>(),
                                                  picked
                                                      .toIso8601String()
                                                      .split('T')
                                                      .first,
                                                );
                                              },
                                            );
                                          }

                                          // Default text field with controller and focus node
                                          return TextFormField(
                                            initialValue: initial ?? '',
                                            keyboardType:
                                                getKeyboardType(label),
                                            cursorColor: Colors.grey[700],
                                            textAlign: TextAlign.start,
                                            style:
                                                const TextStyle(fontSize: 16),
                                            decoration: InputDecoration(
                                              labelText: label,
                                              prefixIcon: Icon(icon,
                                                  color: buttons_blue),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: BorderSide(
                                                    color: buttons_blue,
                                                    width: 2),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              labelStyle: TextStyle(
                                                  color: Colors.grey[700]),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 8),
                                            ),
                                            onChanged: (val) {
                                              if (label == 'Your height' ||
                                                  label == 'Your weight') {
                                                final number =
                                                    int.tryParse(val);
                                                if (number != null) {
                                                  if (label == 'Your height') {
                                                    context
                                                        .read<
                                                            PersonalInfoCubit>()
                                                        .updateHeight(number);
                                                  } else {
                                                    context
                                                        .read<
                                                            PersonalInfoCubit>()
                                                        .updateWeight(number);
                                                  }
                                                }
                                              } else {
                                                switch (label) {
                                                  case 'Your name':
                                                    context
                                                        .read<
                                                            PersonalInfoCubit>()
                                                        .updateName(val);
                                                    break;
                                                  case 'Your email':
                                                    context
                                                        .read<
                                                            PersonalInfoCubit>()
                                                        .updateEmail(val);
                                                    break;
                                                  case 'Your phone number':
                                                    context
                                                        .read<
                                                            PersonalInfoCubit>()
                                                        .updatePhone(val);
                                                    break;
                                                }
                                              }
                                            },
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 18),
                                      // Next button
                                      SizedBox(
                                        height: 48,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: buttons_blue,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            textStyle: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          child: const Text('Next',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          onPressed: () {
                                            context
                                                .read<PersonalInfoCubit>()
                                                .goToStep(1);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Avatar selector (overlapping, not clickable)
                                Positioned(
                                  top: 0,
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.grey[200],
                                    child: Icon(Icons.person,
                                        size: 40, color: Colors.grey[400]),
                                  ),
                                ),
                              ],
                            ),
                          if (step == 1)
                            Column(
                              children: [
                                // Header with back arrow only
                                Container(
                                  height: 80,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 103, 138, 150),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<PersonalInfoCubit>()
                                                  .goToStep(0);
                                            },
                                            child: Row(
                                              children: [
                                                Icon(Icons.arrow_back_ios_new,
                                                    color: Colors.white,
                                                    size: 24),
                                                const SizedBox(width: 4),
                                                const Text('Back',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 32.0),
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 32),
                                      width: 380,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(32),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 16,
                                            offset: Offset(0, 8),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          // Step indicator
                                          Text(
                                            'Step 2/2',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: buttons_blue,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 16),
                                          // Form fields (as in step 1)
                                          ListView.separated(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: items.length,
                                            separatorBuilder: (_, __) =>
                                                const SizedBox(height: 14),
                                            itemBuilder: (context, index) {
                                              final item = items[index];
                                              final label =
                                                  item['label'] as String;
                                              final initial = (item['initial']
                                                      as dynamic Function(
                                                          PersonalInfoLoaded))(
                                                  state);
                                              final icon = fieldIcons[label] ??
                                                  Icons.info;

                                              // Dropdown fields
                                              if (label == 'Gender') {
                                                return DropdownButtonFormField<
                                                    String>(
                                                  value: genderOptions
                                                          .contains(initial)
                                                      ? initial
                                                      : null,
                                                  decoration: InputDecoration(
                                                    labelText: label,
                                                    prefixIcon: Icon(icon,
                                                        color: buttons_blue),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      borderSide: BorderSide(
                                                          color: buttons_blue,
                                                          width: 2),
                                                    ),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    labelStyle: TextStyle(
                                                        color:
                                                            Colors.grey[700]),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 8),
                                                  ),
                                                  dropdownColor: Colors.white,
                                                  iconEnabledColor:
                                                      buttons_blue,
                                                  items: genderOptions
                                                      .map((e) =>
                                                          DropdownMenuItem(
                                                              value: e,
                                                              child: Text(e)))
                                                      .toList(),
                                                  onChanged: (val) {
                                                    if (val != null)
                                                      (item['update']
                                                              as dynamic Function(
                                                                  PersonalInfoCubit,
                                                                  String))(
                                                          context.read<
                                                              PersonalInfoCubit>(),
                                                          val);
                                                  },
                                                );
                                              }
                                              if (label == 'Activity Level') {
                                                return DropdownButtonFormField<
                                                    String>(
                                                  value: activityOptions
                                                          .contains(initial)
                                                      ? initial
                                                      : null,
                                                  decoration: InputDecoration(
                                                    labelText: label,
                                                    prefixIcon: Icon(icon,
                                                        color: buttons_blue),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      borderSide: BorderSide(
                                                          color: buttons_blue,
                                                          width: 2),
                                                    ),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    labelStyle: TextStyle(
                                                        color:
                                                            Colors.grey[700]),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 8),
                                                  ),
                                                  dropdownColor: Colors.white,
                                                  iconEnabledColor:
                                                      buttons_blue,
                                                  items: activityOptions
                                                      .map((e) =>
                                                          DropdownMenuItem(
                                                              value: e,
                                                              child: Text(e)))
                                                      .toList(),
                                                  onChanged: (val) {
                                                    if (val != null)
                                                      (item['update']
                                                              as dynamic Function(
                                                                  PersonalInfoCubit,
                                                                  String))(
                                                          context.read<
                                                              PersonalInfoCubit>(),
                                                          val);
                                                  },
                                                );
                                              }
                                              if (label == 'Goal') {
                                                return DropdownButtonFormField<
                                                    String>(
                                                  value: goalOptions
                                                          .contains(initial)
                                                      ? initial
                                                      : null,
                                                  decoration: InputDecoration(
                                                    labelText: label,
                                                    prefixIcon: Icon(icon,
                                                        color: buttons_blue),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      borderSide: BorderSide(
                                                          color: buttons_blue,
                                                          width: 2),
                                                    ),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    labelStyle: TextStyle(
                                                        color:
                                                            Colors.grey[700]),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 8),
                                                  ),
                                                  dropdownColor: Colors.white,
                                                  iconEnabledColor:
                                                      buttons_blue,
                                                  items: goalOptions
                                                      .map((e) =>
                                                          DropdownMenuItem(
                                                              value: e,
                                                              child: Text(e)))
                                                      .toList(),
                                                  onChanged: (val) {
                                                    if (val != null)
                                                      (item['update']
                                                              as dynamic Function(
                                                                  PersonalInfoCubit,
                                                                  String))(
                                                          context.read<
                                                              PersonalInfoCubit>(),
                                                          val);
                                                  },
                                                );
                                              }
                                              if (label == 'Your country') {
                                                return DropdownButtonFormField<
                                                    String>(
                                                  value: countryOptions
                                                          .contains(initial)
                                                      ? initial
                                                      : null,
                                                  decoration: InputDecoration(
                                                    labelText: label,
                                                    prefixIcon: Icon(icon,
                                                        color: buttons_blue),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      borderSide: BorderSide(
                                                          color: buttons_blue,
                                                          width: 2),
                                                    ),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    labelStyle: TextStyle(
                                                        color:
                                                            Colors.grey[700]),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 8),
                                                  ),
                                                  dropdownColor: Colors.white,
                                                  iconEnabledColor:
                                                      buttons_blue,
                                                  items: countryOptions
                                                      .map((e) =>
                                                          DropdownMenuItem(
                                                              value: e,
                                                              child: Text(e)))
                                                      .toList(),
                                                  onChanged: (val) {
                                                    if (val != null)
                                                      (item['update']
                                                              as dynamic Function(
                                                                  PersonalInfoCubit,
                                                                  String))(
                                                          context.read<
                                                              PersonalInfoCubit>(),
                                                          val);
                                                  },
                                                );
                                              }
                                              if (label == 'Birthdate') {
                                                final controller =
                                                    TextEditingController(
                                                        text: initial ?? '');
                                                final focusNode = FocusNode();
                                                return TextFormField(
                                                  controller: controller,
                                                  focusNode: focusNode,
                                                  readOnly: true,
                                                  cursorColor: Colors.grey[700],
                                                  decoration: InputDecoration(
                                                    labelText: label,
                                                    prefixIcon: Icon(icon,
                                                        color: buttons_blue),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      borderSide: BorderSide(
                                                          color: buttons_blue,
                                                          width: 2),
                                                    ),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    labelStyle: TextStyle(
                                                        color:
                                                            Colors.grey[700]),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 8),
                                                  ),
                                                  onTap: () async {
                                                    controller.selection =
                                                        TextSelection(
                                                            baseOffset: 0,
                                                            extentOffset:
                                                                controller.text
                                                                    .length);
                                                    DateTime? picked =
                                                        await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.tryParse(
                                                                  initial) ??
                                                              DateTime(2000),
                                                      firstDate: DateTime(1900),
                                                      lastDate: DateTime.now(),
                                                      builder:
                                                          (context, child) {
                                                        return Theme(
                                                          data:
                                                              Theme.of(context)
                                                                  .copyWith(
                                                            colorScheme:
                                                                ColorScheme
                                                                    .light(
                                                              primary:
                                                                  buttons_blue,
                                                              onPrimary:
                                                                  Colors.white,
                                                              onSurface:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          child: child!,
                                                        );
                                                      },
                                                    );
                                                    (item['update']
                                                        as dynamic Function(
                                                            PersonalInfoCubit,
                                                            String))(
                                                      context.read<
                                                          PersonalInfoCubit>(),
                                                      picked
                                                          .toIso8601String()
                                                          .split('T')
                                                          .first,
                                                    );
                                                  },
                                                );
                                              }
                                              // Default text field
                                              return TextFormField(
                                                initialValue: initial ?? '',
                                                keyboardType:
                                                    getKeyboardType(label),
                                                cursorColor: Colors.grey[700],
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    fontSize: 16),
                                                decoration: InputDecoration(
                                                  labelText: label,
                                                  prefixIcon: Icon(icon,
                                                      color: buttons_blue),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    borderSide: BorderSide(
                                                        color: buttons_blue,
                                                        width: 2),
                                                  ),
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  labelStyle: TextStyle(
                                                      color: Colors.grey[700]),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 8,
                                                          vertical: 8),
                                                ),
                                                onChanged: (val) {
                                                  if (label == 'Your height' ||
                                                      label == 'Your weight') {
                                                    final number =
                                                        int.tryParse(val);
                                                    if (number != null) {
                                                      if (label ==
                                                          'Your height') {
                                                        context
                                                            .read<
                                                                PersonalInfoCubit>()
                                                            .updateHeight(
                                                                number);
                                                      } else {
                                                        context
                                                            .read<
                                                                PersonalInfoCubit>()
                                                            .updateWeight(
                                                                number);
                                                      }
                                                    }
                                                  } else {
                                                    switch (label) {
                                                      case 'Your name':
                                                        context
                                                            .read<
                                                                PersonalInfoCubit>()
                                                            .updateName(val);
                                                        break;
                                                      case 'Your email':
                                                        context
                                                            .read<
                                                                PersonalInfoCubit>()
                                                            .updateEmail(val);
                                                        break;
                                                      case 'Your phone number':
                                                        context
                                                            .read<
                                                                PersonalInfoCubit>()
                                                            .updatePhone(val);
                                                        break;
                                                    }
                                                  }
                                                },
                                              );
                                            },
                                          ),
                                          const SizedBox(height: 18),
                                          // Calculate button
                                          SizedBox(
                                            height: 48,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: buttons_blue,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                textStyle: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              child: const Text(
                                                  'Calculate Calories',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              onPressed: () {
                                                context
                                                    .read<PersonalInfoCubit>()
                                                    .submitForm();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
      ),
    );
  }
}
