import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:nutria/Screens/recommenderSystem/recommendation_result_screen.dart';
import 'package:nutria/Widgets/assets/colors.dart';

class Questions extends StatefulWidget {
  const Questions({super.key});

  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController restrictionsController = TextEditingController();
  final TextEditingController allergiesController = TextEditingController();
  final TextEditingController cookingTimeController = TextEditingController();

  // Dropdown selected values
  String? selectedMealType;
  String? selectedCookingSkill;
  String? selectedCuisine;
  String? selectedFlavor;
  String? selectedSpicyLevel;
  int? selectedNumberOfMeals;

  Map<String, dynamic> getMissingFields() {
    return {
      "Height": 170,
      "Weight": 65,
      "Activity_Level": "Moderately active",
      "Gender": "female",
      "Age": 28,
      "Goal": "weight loss",
    };
  }

  bool isLoading = false;

  Future<void> sendRecommendationRequest() async {
    if (!_formKey.currentState!.validate()) return;

    // Prepare form data
    final Map<String, dynamic> formData = {
      "Restrictions": restrictionsController.text.trim(),
      "Allergies": allergiesController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList(),
      "Meal_type": selectedMealType?.toLowerCase(),
      "Time": int.tryParse(cookingTimeController.text.trim()),
      "Cooking_skills": selectedCookingSkill?.toLowerCase(),
      "Cuisine": selectedCuisine,
      "flavor": selectedFlavor?.toLowerCase(),
      "Spicy_level": selectedSpicyLevel?.toLowerCase(),
      "n_meals": selectedNumberOfMeals,
    };

    // Remove null or empty keys
    formData.removeWhere((key, value) =>
        value == null || (value is String && value.isEmpty) || (value is List && value.isEmpty));

    // Add missing fields
    formData.addAll(getMissingFields());

    setState(() {
      isLoading = true;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(child: CircularProgressIndicator()),
    );

    print('Sending JSON: $formData');

    try {
      final response = await http.post(
        Uri.parse('https://13d4-41-111-187-83.ngrok-free.app/recommand'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(formData),
      );

      Navigator.of(context).pop();

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Response data: $data');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Recommendation received!')),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecommendationResultScreen(data: data),
          ),
        );
      } else {
        print('Server error: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server error: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('Error sending request: $e');
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sending request')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    restrictionsController.dispose();
    allergiesController.dispose();
    cookingTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.grey[700]),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Your Info",
          style: TextStyle(
            fontSize: 25,
            color: Colors.grey[700],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(20.0),
            sliver: SliverToBoxAdapter(
              child: buildForm(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: sendRecommendationRequest,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttons_blue,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Get recommendation',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.apple, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildTextField('Restrictions', controller: restrictionsController),
          buildTextField('Allergies (comma separated)', controller: allergiesController),

          // Meal type dropdown
          buildDropdownField<String>(
            label: 'Meal type',
            items: const ['Breakfast', 'Lunch', 'Dinner', 'Snack'],
            value: selectedMealType,
            onChanged: (val) => setState(() => selectedMealType = val),
            validator: (val) => val == null ? 'Please select a meal type' : null,
          ),

          // Cooking time field - accepts only numbers
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: TextFormField(
              controller: cookingTimeController,
              decoration: InputDecoration(
                labelText: 'Cooking time (in minutes)',
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
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (val) =>
                  val == null || val.isEmpty ? 'Please enter cooking time' : null,
            ),
          ),

          // Cooking skills dropdown
          buildDropdownField<String>(
            label: 'Cooking skills',
            items: const ['Beginner', 'Intermediate', 'Advanced'],
            value: selectedCookingSkill,
            onChanged: (val) => setState(() => selectedCookingSkill = val),
            validator: (val) => val == null ? 'Please select cooking skills level' : null,
          ),

          // Cuisine dropdown
          buildDropdownField<String>(
            label: 'Cuisine',
            items: const [
              'Italian',
              'French',
              'Japanese',
              'Chinese',
              'Indian',
              'Mexican',
              'Thai',
              'Korean',
              'Mediterranean',
              'American',
              'Middle Eastern',
              'Spanish',
              'Vietnamese',
              'Greek',
              'Turkish',
              'Brazilian',
              'Moroccan',
              'Ethiopian',
              'Caribbean',
              'German',
            ],
            value: selectedCuisine,
            onChanged: (val) => setState(() => selectedCuisine = val),
            validator: (val) => val == null ? 'Please select a cuisine' : null,
          ),

          // Flavor dropdown
          buildDropdownField<String>(
            label: 'Flavor',
            items: const [
              'Sweet',
              'Savory',
              'Sour',
              'Bitter',
              'Umami',
              'Salty',
              'Spicy',
              'Smoky',
              'Fruity',
              'Earthy',
              'Herby',
              'Tangy',
              'Nutty',
              'Creamy',
              'Zesty',
              'Garlicky',
              'Buttery',
            ],
            value: selectedFlavor,
            onChanged: (val) => setState(() => selectedFlavor = val),
            validator: (val) => val == null ? 'Please select a flavor' : null,
          ),

          // Spicy level dropdown
          buildDropdownField<String>(
            label: 'Spicy level',
            items: const ['Plain', 'Spicy', 'Very Spicy'],
            value: selectedSpicyLevel,
            onChanged: (val) => setState(() => selectedSpicyLevel = val),
            validator: (val) => val == null ? 'Please select a spicy level' : null,
          ),

          // Number of meals dropdown
          buildDropdownField<int>(
            label: 'Number of meals',
            items: List.generate(6, (index) => index + 1),
            value: selectedNumberOfMeals,
            onChanged: (val) => setState(() => selectedNumberOfMeals = val),
            validator: (val) => val == null ? 'Please select number of meals' : null,
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String label,
      {TextEditingController? controller, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
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
      ),
    );
  }

  Widget buildDropdownField<T>({
    required String label,
    required List<T> items,
    T? value,
    required void Function(T?) onChanged,
    String? Function(T?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: DropdownButtonFormField<T>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
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
        items: items.map((item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(item.toString()),
          );
        }).toList(),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
