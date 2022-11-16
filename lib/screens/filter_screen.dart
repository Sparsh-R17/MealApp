import 'package:flutter/material.dart';
import '/widgets/main_drawer.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  static const routeName = '/filters';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your filters'),
      ),
      drawer: const MainDrawer(),
      body: const Center(
        child: Text('FILTERS...'),
      ),
    );
  }
}
