import 'package:flutter/material.dart';

import 'dummy_data.dart';
import './models/meal.dart';
import './screens/categories_screen.dart';
import './screens/category_meal_screen.dart';
import './screens/filter_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tab_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    'glutenFree': false,
    'vegan': false,
    'vegetarian': false,
    'lactoseFree': false,
  };

  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];

  void toggleFavorites(String mealId) {
    int existingIndex = favoriteMeals.indexWhere((val) => val.id == mealId);
    if (existingIndex >= 0) {
      setState(() => favoriteMeals.removeAt(existingIndex));
    } else {
      setState(() =>
          favoriteMeals.add(DUMMY_MEALS.firstWhere((val) => val.id == mealId)));
    }
  }

  bool isMealFavorite(String id) {
    return favoriteMeals.any((ele) => ele.id == id);
  }

  void setFilters(Map<String, bool> newFilters) {
    setState(() {
      filters = newFilters;
      availableMeals = DUMMY_MEALS.where((element) {
        if (filters['glutenFree']! && !element.isGlutenFree) {
          return false;
        }
        if (filters['vegan']! && !element.isVegan) {
          return false;
        }
        if (filters['vegetarian']! && !element.isVegetarian) {
          return false;
        }
        if (filters['lactoseFree']! && !element.isVegetarian) {
          return false;
        } else {
          return true;
        }
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.pink,
        canvasColor: const Color.fromRGBO(255, 234, 240, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Color.fromRGBO(25, 30, 25, 1),
              ),
              bodyText2: const TextStyle(
                color: Color.fromRGBO(45, 90, 35, 1),
              ),
              subtitle1: const TextStyle(
                fontSize: 24.0,
                fontFamily: 'RobotoCondensed',
              ),
            ),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.amber),
      ),
      //home: MyHomePage(),
      //home: CategoriesScreen(),
      routes: {
        '/': (context) => TabScreen(favoriteMeals),
        CategoryMealScreen.routeName: (context) =>
            CategoryMealScreen(availableMeals),
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(toggleFavorites, isMealFavorite),
        FilterScreen.routeName: (context) => FilterScreen(filters, setFilters),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CategoriesScreen(),
    );
  }
}
