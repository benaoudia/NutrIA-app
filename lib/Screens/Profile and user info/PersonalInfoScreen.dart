import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutria/Blocs/profile_blocs/profileBloc.dart';
import 'package:nutria/Screens/Profile%20and%20user%20info/personalInfoitems.dart';
import 'package:nutria/Widgets/assets/colors.dart';

class PersonalInfo extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  PersonalInfo({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.grey[700]),
              onPressed: () => Navigator.pop(context),
            ),
            title: Column(
              children: [
                Text("Your Info", 
                  style: TextStyle(fontSize: 25, color: Colors.grey[700], fontWeight: FontWeight.bold),
                ),
                Text("Step 2/2",
                  style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                )
              ],
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          BlocConsumer<PersonalInfoCubit,PersonalInfoState>(
            listener: (context, state) {
              if(state is PersonalInfoError){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage)),
                );
              }
            },
            builder: (context,state){
              if(state is PersonalInfoLoading) {
                return SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator(color: buttons_blue)),
                );
              }
              else if (state is PersonalInfoLoaded){
                final cubit = context.read<PersonalInfoCubit>();
                return SliverPadding(
                  padding: EdgeInsets.all(20.0),
                  sliver: build_form(_formKey, cubit, state, context),
                );
              }
              return SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Wait for a moment!", 
                      style: TextStyle(
                        color: Colors.grey[700], 
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the nutritional values screen
            Navigator.pushNamed(context, '/nutritional-values');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: buttons_blue,
            padding: EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Calculate Nutritional Values',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.calculate, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

Widget build_form(GlobalKey<FormState> _formKey, PersonalInfoCubit cubit, PersonalInfoLoaded state, BuildContext context) {
  return SliverToBoxAdapter(
    child: Form(
      key: _formKey,
      child: Column(
        children: labels.map((item) {
          final label = item['label'] as String;
          final initialValue = (item['initial'] as Function(PersonalInfoLoaded))(state);
          final onChanged = (String val) => (item['update'] as Function(PersonalInfoCubit, String))(cubit, val);

          IconData? icon;
          switch (label) {
            case 'Your name':
              icon = Icons.person_outline;
              break;
            case 'Your phone number':
              icon = Icons.phone;
              break;
            case 'Your email':
              icon = Icons.email;
              break;
            case 'Your country':
              icon = Icons.location_on;
              break;
          }

          if (label == 'Your country') {
            return _buildDropdownField(
              context: context,
              label: label,
              value: initialValue,
              items: const ['','USA', 'Canada', 'UK', 'Australia', 'France', 'Germany', 'Japan', 'China', 'India'],
              onChanged: (val) => onChanged(val ?? ''),
              icon: icon,
            );
          }

          return Column(
            children: [
              TextFormField(
                initialValue: initialValue,
                decoration: InputDecoration(
                  labelText: label,
                  prefixIcon: Icon(icon, color: buttons_blue),
                  labelStyle: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: buttons_blue,
                      width: 2.0,
                    ),
                  ),
                ),
                onChanged: onChanged,
              ),
              SizedBox(height: 20),
            ],
          );
        }).toList(),
      ),
    ),
  );
}

Widget _buildDropdownField({
  required BuildContext context,
  required String label,
  required String? value,
  required List<String> items,
  required Function(String?) onChanged,
  required IconData? icon,
}) {
  return Column(
    children: [
      DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: buttons_blue),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: buttons_blue,
              width: 2.0,
            ),
          ),
        ),
        items: items.map((String item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
      SizedBox(height: 20),
    ],
  );
} 