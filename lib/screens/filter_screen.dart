import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filter';
  final Map<String, bool> currentFilters;
  final Function setFilters;
  const FilterScreen(this.currentFilters, this.setFilters, {Key? key})
      : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool? glutenFree = false;
  bool? vegan = false;
  bool? vegetarian = false;
  bool? lactoseFree = false;

  @override
  void initState() {
    glutenFree = widget.currentFilters['glutenFree'];
    vegan = widget.currentFilters['vegan'];
    vegetarian = widget.currentFilters['vegetarian'];
    lactoseFree = widget.currentFilters['lactoseFree'];
    super.initState();
  }

  Widget buildSwitchListTile({
    required String title,
    required String subTitle,
    required bool value,
    required Function updateValue,
  }) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: updateValue as void Function(bool)?,
      subtitle: Text(subTitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              setState(() {
                final Map<String, bool?> selectFilters = {
                  'glutenFree': glutenFree,
                  'vegan': vegan,
                  'vegetarian': vegetarian,
                  'lactoseFree': lactoseFree,
                };
                widget.setFilters(selectFilters);
              });
            },
          )
        ],
        title: const Text('Filters'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust Your Meal Selection',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              buildSwitchListTile(
                  title: 'Gluten-Free',
                  subTitle: 'Only include Gluten-Free Meals',
                  value: glutenFree!,
                  updateValue: (newValue) {
                    setState(() {
                      glutenFree = newValue;
                    });
                  }),
              buildSwitchListTile(
                  title: 'Vegan',
                  value: vegan!,
                  subTitle: 'Only include Vegan Meals',
                  updateValue: (newValue) {
                    setState(() {
                      vegan = newValue;
                    });
                  }),
              buildSwitchListTile(
                  title: 'Vegetarian',
                  subTitle: 'Only include Vegetarian Meals',
                  value: vegetarian!,
                  updateValue: (newValue) {
                    setState(() {
                      vegetarian = newValue;
                    });
                  }),
              buildSwitchListTile(
                  title: 'LactoseFree',
                  subTitle: 'Only include Lactose-Free Meals',
                  value: lactoseFree!,
                  updateValue: (newValue) {
                    setState(() {
                      lactoseFree = newValue;
                    });
                  }),
            ],
          ))
        ],
      ),
      drawer: const MainDrawer(),
    );
  }
}
