import 'package:flutter/material.dart';
import '../widgets/category_item.dart';
import '../dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageWidth = MediaQuery.of(context).size.width;

    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: GridView(
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: pageWidth * 0.5, //the max width any grid can have
          childAspectRatio: 1.2, //the ratio of height to width
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: DUMMY_CATEGORIES
            .map(
              (catData) => CategoryItem(
                id: catData.id,
                title: catData.title,
                bgcolor: catData.color,
              ),
            )
            .toList(),
      ),
    );
  }
}
