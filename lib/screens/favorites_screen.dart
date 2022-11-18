import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  final Function toggleFavorite;
  final Function isMealFavorite;

  const FavoritesScreen({
    super.key,
    required this.favoriteMeals,
    required this.toggleFavorite,
    required this.isMealFavorite,
  });

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  void _removeMeal(String mealId) {
    setState(() {
      widget.favoriteMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.favoriteMeals.isEmpty) {
      return const Center(
        child: Text('You have no favorites yes - start adding some!'),
      );
    } else {
      return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return true;
        },
        child: ListView.builder(
          itemCount: widget.favoriteMeals.length,
          itemBuilder: (ctx, index) {
            return MealItem(
              id: widget.favoriteMeals[index].id,
              title: widget.favoriteMeals[index].title,
              imageUrl: widget.favoriteMeals[index].imageUrl,
              duration: widget.favoriteMeals[index].duration,
              affordability: widget.favoriteMeals[index].affordability,
              complexity: widget.favoriteMeals[index].complexity,
              isVegetarian: widget.favoriteMeals[index].isVegetarian,
              removeItem: _removeMeal,
              toggleFavorite: widget.toggleFavorite,
              isMealFavorite: widget.isMealFavorite,
            );
          },
        ),
      );
    }
  }
}
