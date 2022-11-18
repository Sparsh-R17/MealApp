import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  final List<Meal> availableMeals;
  final Function toggleFavorite;
  final Function isMealFavorite;

  const CategoryMealsScreen(
      {super.key,
      required this.availableMeals,
      required this.toggleFavorite,
      required this.isMealFavorite});
  static const routeName = '/category-meals';

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? categoryTitle;
  List<Meal>? displayedMeals;
  // List<Meal> _favoriteMeal = [];
  var _loadedInitData = false;

  @override
  void initState() {
    //we can use this if context is not used in the code else use didChangeDependencies.
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_loadedInitData == false) {
      final routesArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;

      categoryTitle = routesArgs['title'];
      final categoryId = routesArgs['id'];
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }

    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals?.removeWhere((meal) => meal.id == mealId);
    });
  }

  // void _toggleFavorite(String mealId) {
  //   final existingIndex = _favoriteMeal.indexWhere((meal) => meal.id == mealId);
  //   if (existingIndex >= 0) {
  //     setState(() {
  //       _favoriteMeal.removeAt(existingIndex);
  //     });
  //   } else {
  //     setState(() {
  //       _favoriteMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return true;
        },
        child: ListView.builder(
          itemCount: displayedMeals!.length,
          itemBuilder: (ctx, index) {
            return MealItem(
              id: displayedMeals![index].id,
              title: displayedMeals![index].title,
              imageUrl: displayedMeals![index].imageUrl,
              duration: displayedMeals![index].duration,
              affordability: displayedMeals![index].affordability,
              complexity: displayedMeals![index].complexity,
              isVegetarian: displayedMeals![index].isVegetarian,
              removeItem: _removeMeal,
              toggleFavorite: widget.toggleFavorite,
              isMealFavorite: widget.isMealFavorite,
            );
          },
        ),
      ),
    );
  }
}
