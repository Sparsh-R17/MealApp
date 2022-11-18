import 'package:flutter/material.dart';
import 'package:meal_app/screens/meal_detail_screen.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final Function removeItem;
  final bool isVegetarian;
  final Function toggleFavorite;
  final Function isMealFavorite;

  const MealItem({
    super.key,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.affordability,
    required this.complexity,
    required this.removeItem,
    required this.isVegetarian,
    required this.toggleFavorite,
    required this.isMealFavorite,
  });

  String get complexityText {
    switch (complexity) {
      case Complexity.simple:
        return 'Simple';
      case Complexity.hard:
        return 'Hard';
      case Complexity.challenging:
        return 'Challenging';
      default:
        return 'Unknown';
    }
  }

  String get affordabilityText {
    switch (affordability) {
      case Affordability.affordable:
        return 'Affordable';
      case Affordability.luxurious:
        return 'Luxurious';
      case Affordability.pricey:
        return 'Pricey';
      default:
        return 'Unknown';
    }
  }

  void selectMeal(context) {
    Navigator.of(context)
        .pushNamed(
      MealDetailScreen.routeName,
      arguments: id,
    )
        .then((result) {
      //this line is executed when the page is popped which was pushed earlier
      // print(result);
      if (result != null) {
        removeItem(result);
      }
    });
  }

  Widget dataDisplay(IconData icons, String data) {
    return Row(
      children: [
        Icon(icons),
        const SizedBox(
          width: 6,
        ),
        Text(
          data,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        color: isVegetarian ? Colors.green.shade50 : Colors.red.shade50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 0,
                  child: Container(
                    color: Colors.black54,
                    width: 250,
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 21,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  dataDisplay(Icons.schedule, '$duration min'),
                  dataDisplay(Icons.work, complexityText),
                  dataDisplay(Icons.attach_money, affordabilityText),
                  IconButton(
                    onPressed: () => toggleFavorite(id),
                    icon: isMealFavorite(id)
                        ? Icon(
                            Icons.favorite,
                            color: Theme.of(context).colorScheme.primary,
                          )
                        : const Icon(Icons.favorite_border),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
