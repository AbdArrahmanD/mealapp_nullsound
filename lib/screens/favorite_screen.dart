import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;
  const FavoriteScreen(this.favoriteMeals, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return const Center(
        child: Text(
          'You have no Favorite yet',
        ),
      );
    } else {
      return Scaffold(
        body: ListView.builder(
          itemBuilder: (context, index) {
            return MealItem(
              id: favoriteMeals[index].id,
              title: favoriteMeals[index].title,
              duration: favoriteMeals[index].duration,
              complexity: favoriteMeals[index].complexity,
              affordability: favoriteMeals[index].affordability,
              imagUrl: favoriteMeals[index].imageUrl,
              //removeItem: removeMeal,
            );
          },
          itemCount: favoriteMeals.length,
        ),
      );
    }
  }
}
