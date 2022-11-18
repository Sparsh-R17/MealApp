import 'package:flutter/material.dart';

import 'dummy_data.dart';
import './screens/filter_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import 'screens/category_meals_screen.dart';
import './models/meal.dart';
// import 'screens/categories_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeal = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(
      () {
        _filters = filterData;

        _availableMeals = DUMMY_MEALS.where(
          (meal) {
            if (_filters['gluten']! && !meal.isGlutenFree) {
              return false;
            }
            if (_filters['vegan']! && !meal.isVegan) {
              return false;
            }
            if (_filters['lactose']! && !meal.isLactoseFree) {
              return false;
            }
            if (_filters['vegetarian']! && !meal.isVegetarian) {
              return false;
            }

            return true;
            //...
          },
        ).toList();
      },
    );
  }

  void _toggleFavorite(String mealId) {
    final existingIndex = _favoriteMeal.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeal.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String mealId) {
    return _favoriteMeal.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
        //     .copyWith(secondary: Colors.amber),
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.pink, accentColor: Colors.amber),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline1: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // home: const MyHomePage(),
      routes: {
        '/': (context) => TabsScreen(
            isMealFavorite: _isMealFavorite,
            toggleFavorite: _toggleFavorite,
            favoriteMeals: _favoriteMeal),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(
            isMealFavorite: _isMealFavorite,
            toggleFavorite: _toggleFavorite,
            availableMeals: _availableMeals),
        MealDetailScreen.routeName: (context) => const MealDetailScreen(),
        FilterScreen.routeName: (context) =>
            FilterScreen(currentFilters: _filters, saveFilters: _setFilters),
      },
    );
  }
}
