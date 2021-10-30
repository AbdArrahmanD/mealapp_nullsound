import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../screens/categories_screen.dart';
import '../screens/favorite_screen.dart';
import '../widgets/main_drawer.dart';

class TabScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  const TabScreen(this.favoriteMeals, {Key? key}) : super(key: key);
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  late List<Map<String, Object>> pages;

  @override
  void initState() {
    pages = [
      {
        'title': 'Categories',
        'page': const CategoriesScreen(),
      },
      {
        'title': 'Favorites',
        'page': FavoriteScreen(widget.favoriteMeals),
      },
    ];
    super.initState();
  }

  int selectedPageIndex = 0;
  void selectScreen(index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(pages[selectedPageIndex]['title'] as String),
      ),
      body: pages[selectedPageIndex]['page'] as Widget?,
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectScreen,
        currentIndex: selectedPageIndex,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: const MainDrawer(),
    );
  }
}
