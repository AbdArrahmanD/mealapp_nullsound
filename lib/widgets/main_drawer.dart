import 'package:flutter/material.dart';
import '../screens/filter_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget buildListTile({required String title, IconData? icon, Function? function}) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      onTap: function as void Function()?,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            color: Theme.of(context).colorScheme.secondary,
            height: 100,
            width: double.infinity,
            child: Text(
              ' Cooking Up!',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          buildListTile(
            function: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
            title: 'Meals',
            icon: Icons.restaurant,
          ),
          buildListTile(
            function: () {
              Navigator.of(context)
                  .pushReplacementNamed(FilterScreen.routeName);
            },
            title: 'Filter',
            icon: Icons.filter_alt,
          ),
        ],
      ),
    );
  }
}
