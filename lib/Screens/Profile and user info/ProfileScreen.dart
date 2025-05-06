import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutria/Blocs/profile_blocs/profileBloc.dart';
import 'package:nutria/Screens/Profile%20and%20user%20info/form_items.dart';
import 'package:nutria/Widgets/assets/colors.dart';

class ProfileScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  ProfileScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: false,
          floating: false,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Icon(Icons.arrow_back_ios_new , color: Colors.grey[700],),
          title: Column(
            children: [
              Text("Your Info", style: 
          TextStyle(fontSize: 25, color: Colors.grey[700]),),
          Text("Step 2/2",
          style: TextStyle(fontSize: 15, color: Colors.grey[600]),)
            ],
          )
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
                  child: Center(child: CircularProgressIndicator(color: Colors.grey[700],),)
                );
              }
              else if (state is PersonalInfoLoaded){
                final cubit = context.read<PersonalInfoCubit>();
                  return SliverPadding(
                    padding: EdgeInsets.all(20.0),
                    sliver: 
                    build_form(_formKey,cubit, state,context),
                    // SliverList(
                    //   delegate: SliverChildListDelegate(
                    //     // [Text("here trur")]
                    //     [build_form(_formKey,cubit, state,context),]
                    //   )
                    //   )
                  );
              }
              return SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text("Wait for a moment!" , 
                      style: TextStyle(
                        color: Colors.grey[700], 
                        fontSize: 22),),
                    )
                    ),
                ),
              );
            },
          ),
      ],
    );
  }
}



// Widget build_form(GlobalKey<FormState> _formKey, PersonalInfoCubit cubit, PersonalInfoLoaded state, BuildContext context){
//   return SliverToBoxAdapter(
//   child: Padding(
//     padding: EdgeInsets.all(16.0),
//     child: Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           for (var item in labels)
//             // _buildTextField(
//             //   context: context,
//             //   label: item['label'] as String,
//             //   initialValue: (item['initial'] as String Function(PersonalInfoLoaded))(state as PersonalInfoLoaded),
//             //   onChanged: (val) => (item['update'] as Function)(cubit, val),

//             //   )
//             Text("here trur")
//         ],
//       ),
//       ),
//     )
//   );
// }

Widget build_form(GlobalKey<FormState> _formKey, PersonalInfoCubit cubit, PersonalInfoLoaded state, BuildContext context) {
  return Form(
        key: _formKey,
        child: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              var item = labels[index];
              return _buildTextField(
                context: context,
                label: item['label'] as String,
                initialValue: (item['initial'] as String Function(PersonalInfoLoaded))(state),
                onChanged: (val) => (item['update'] as Function)(cubit, val),
              );
            },
            childCount: labels.length,
          ),
        ),
      );
}


Widget _buildTextField(
  {
  required BuildContext context,
  required String label,
  required String initialValue,
  required Function(String) onChanged
  }
){
  if (label == 'Activity Level'){
    return _buildDropdownField(
      label: label,
      value: initialValue,
      items: const ['','Sedentary', 'Light', 'Moderate', 'Active', 'Very Active'], //double check
      onChanged: (val) => onChanged(val ?? ''),
    );
  }
  else if (label == 'Gender'){
    return _buildDropdownField(
      label: label,
      value: initialValue,
      items: const ['','Male', 'Female'], // double check
      onChanged: (val) => onChanged(val ?? ''),
    );
  }
  else if (label == 'Goal'){
    return _buildDropdownField(
      label: label,
      value: initialValue,
      items: const ['','Weight Loss', 'Maintenance', 'Muscle Gain'], // double check
      onChanged: (val) => onChanged(val ?? ''),
    );
  }
  else if (label == 'Birthdate'){
    return _buildDateField(
      context: context,
      label: label,
      initialValue: initialValue,
      onChanged: (val) => onChanged(val),
    );
  }
  return Column(
    children: [
      TextFormField(
    initialValue: initialValue,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: Colors.grey[500],
        fontSize: 20,
      ),
      border: const OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: buttons_blue,
          width: 2.0,
        )
      )
    ),
    onChanged: onChanged,
  ),
  SizedBox(height: 35,)
    ],
  );
}



Widget _buildDropdownField({
  required String label,
  required String? value,
  required List<String> items,
  required Function(String?) onChanged,
}){
  return Column(
    children: [
      DropdownButtonFormField<String>(
    value: value,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: Colors.grey[500],
        fontSize: 20,
      ),
      border: const OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: buttons_blue,
          width: 2.0,
        )
      )
    ),
    items: items.map((String item){
      return DropdownMenuItem(
        value: item,
        child: Text(item)
      );
    }).toList(),
    onChanged: onChanged,
  ),
  SizedBox(height:35 ,)
    ],
  );

}



Widget _buildDateField({
  required BuildContext context,
  required String label,
  required String initialValue,
  required Function(String) onChanged,
}){
  return TextFormField(
    initialValue: initialValue,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: Colors.grey[500],
        fontSize: 20,
      ),
      border: const OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: buttons_blue,
          width: 2.0,
        )
      ),
      hintText: 'YYYY-MM-DD',
      suffixIcon: const Icon(Icons.calendar_today), 
    ),
    onChanged: onChanged,
    // onTap: () async {
    //   FocusScope.of(context).requestFocus(FocusNode());
    // },
  );
}