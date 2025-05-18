import 'package:flutter/material.dart';

class RecommendationResultScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const RecommendationResultScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final String name = data['name'] ?? "Unnamed Recipe";
    final int minutes = data['minutes'] ?? 0;
    final List<dynamic> ingredients = data['ingredients'] ?? [];
    final List<dynamic> steps = data['steps'] ?? [];
    final List<dynamic> nutrition = data['nutrition'] ?? [];

    final List<String> nutritionLabels = [
      'Calories',
      'Total Fat (PDV)',
      'Sugar (PDV)',
      'Sodium (PDV)',
      'Protein (PDV)',
      'Saturated Fat (PDV)',
      'Carbohydrates (PDV)',
    ];

    const Color sectionColor = Color.fromARGB(255, 103, 138, 150);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipe Recommendation"),
        backgroundColor: sectionColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.schedule, color: sectionColor),
                const SizedBox(width: 6),
                Text(
                  "Ready in $minutes minutes",
                  style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                ),
              ],
            ),
            const Divider(height: 24),

            // Nutrition Information Section
            if (nutrition.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.local_dining, color: sectionColor),
                      const SizedBox(width: 6),
                      const Text(
                        "Nutrition Information:",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...List.generate(nutrition.length, (index) {
                    return Text("- ${nutritionLabels[index]}: ${nutrition[index]}");
                  }),
                  const Divider(height: 24),
                ],
              ),

            Row(
              children: [
                Icon(Icons.shopping_cart, color: sectionColor),
                const SizedBox(width: 6),
                const Text(
                  "Ingredients:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...ingredients.map((item) => Text("- $item")).toList(),
            const Divider(height: 24),

            Row(
              children: [
                Icon(Icons.menu_book, color: sectionColor),
                const SizedBox(width: 6),
                const Text(
                  "Steps:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...List.generate(
              steps.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text("${index + 1}. ${steps[index]}"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
