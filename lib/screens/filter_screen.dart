import 'package:flutter/material.dart';
import '/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  const FilterScreen(
      {super.key, required this.saveFilters, required this.currentFilters});

  static const routeName = '/filters';

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;
  var _glutenFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten']!;
    _lactoseFree = widget.currentFilters['lactose']!;
    _vegan = widget.currentFilters['vegan']!;
    _vegetarian = widget.currentFilters['vegetarian']!;

    super.initState();
  }

  Widget _buildSwitch(String title, String description, bool currentValue,
      void Function(bool) updateValue) {
    return SwitchListTile(
      activeColor: Theme.of(context).colorScheme.secondary,
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your filters'),
        actions: [
          IconButton(
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                };
                widget.saveFilters(selectedFilters);
              },
              icon: Icon(Icons.save_as_outlined))
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text('Adjust your meal selection.',
                style: Theme.of(context).textTheme.titleMedium),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitch(
                  'Gluten Free',
                  'Only include gluten-free meals ',
                  _glutenFree,
                  (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  },
                ),
                _buildSwitch(
                  'Lactose Free',
                  'Only include lactose-free meals ',
                  _lactoseFree,
                  (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  },
                ),
                _buildSwitch(
                  'Vegetarian',
                  'Only include Vegetarian meals ',
                  _vegetarian,
                  (newValue) {
                    setState(() {
                      _vegetarian = newValue;
                    });
                  },
                ),
                _buildSwitch(
                  'Vegan',
                  'Only include Vegan meals ',
                  _vegan,
                  (newValue) {
                    setState(() {
                      _vegan = newValue;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
