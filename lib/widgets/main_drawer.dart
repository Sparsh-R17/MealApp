import 'package:flutter/material.dart';
import 'package:meal_app/screens/filter_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  Widget _buildListTile(
      String title, IconData icon, void Function()? tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 27,
      ),
      title: Transform.translate(
        offset: const Offset(-20, 0),
        child: Text(
          title,
          style: const TextStyle(fontSize: 17),
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: pageHeight * 0.2,
            width: double.infinity,
            color: Theme.of(context).colorScheme.secondary,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Text(
              'Cooking Meal !',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontFamily: 'RobotoCondensed',
                  fontSize: 30),
            ),
          ),
          SizedBox(
            height: pageHeight * 0.03,
          ),
          _buildListTile(
            'Meals',
            Icons.restaurant_menu,
            () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          _buildListTile(
            'Filters',
            Icons.settings,
            () {
              Navigator.of(context)
                  .pushReplacementNamed(FilterScreen.routeName);
            },
          )
        ],
      ),
    );
  }
}
