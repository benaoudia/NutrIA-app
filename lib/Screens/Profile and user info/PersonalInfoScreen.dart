import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutria/Blocs/profile_blocs/profileBloc.dart';
import 'package:nutria/Screens/Profile%20and%20user%20info/personalInfoitems.dart';

class PersonalInfo extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  PersonalInfo({super.key});
  
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: Icon(Icons.arrow_back_ios_new , color: Colors.grey[700],),
          title: Column(
            children: [
              Text("Your Info", style: 
          TextStyle(fontSize: 25, color: Colors.grey[700]),),
          Text("Step 1/2",
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
                    padding: EdgeInsets.all(0),
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
  
  if (label == 'Country'){
    return _buildDropdownField(
      label: label,
      value: initialValue,
      items: const ['','Weight Loss', 'Maintenance', 'Muscle Gain'], // double check
      onChanged: (val) => onChanged(val ?? ''),
    );
  }
  return TextFormField(
    initialValue: initialValue,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: Colors.grey[750],
        fontSize: 16,
        
      ),
      border: const OutlineInputBorder(),
    ),
    onChanged: onChanged,
  );
}



Widget _buildDropdownField({
  required String label,
  required String? value,
  required List<String> items,
  required Function(String?) onChanged,
}){
  return DropdownButtonFormField<String>(
    value: value,
    decoration: InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    ),
    items: items.map((String item){
      return DropdownMenuItem(
        value: item,
        child: Text(item)
      );
    }).toList(),
    onChanged: onChanged,
  );

}