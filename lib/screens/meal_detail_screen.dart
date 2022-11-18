import 'package:flutter/material.dart';

import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({super.key});

  static const routeName = '/meal-detail';

  Widget buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }

  Widget buildContainerBox(final pageHeight, final pageWidth, Widget child) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      height: pageHeight * 0.2,
      width: pageWidth * 0.8,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: SizedBox.fromSize(
                child: Image.network(
                  selectedMeal.imageUrl,
                  fit: BoxFit.fill,
                  height: pageHeight * 0.3,
                  width: double.infinity,
                ),
              ),
            ),
          ),
          buildSectionTitle(context, 'Ingredients'),
          buildContainerBox(
            pageHeight,
            pageWidth,
            ListView.builder(
              itemCount: selectedMeal.ingredients.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Text(
                      selectedMeal.ingredients[index],
                    ),
                  ),
                );
              },
            ),
          ),
          buildSectionTitle(context, 'Steps'),
          buildContainerBox(
            pageHeight,
            pageWidth,
            ListView.builder(
              itemCount: selectedMeal.steps.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Text('# ${index + 1}'),
                      ),
                      title: Text(
                        selectedMeal.steps[index],
                      ),
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.delete),
        onPressed: () {
          Navigator.of(context).pop(mealId);
        },
      ),
    );
  }
}
