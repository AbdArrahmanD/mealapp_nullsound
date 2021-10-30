import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal_detail';
  final Function toggelFavoriteMeal;
  final Function isMealFavorite;
  const MealDetailScreen(this.toggelFavoriteMeal, this.isMealFavorite,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildWidget(BuildContext context, String title) {
      return Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      );
    }

    Widget buildContainer(Widget child, double height) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: height,
        width: 400,
        child: child,
      );
    }

    final String? mealId = ModalRoute.of(context)!.settings.arguments as String?;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.asset(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildWidget(context, 'Ingredients'),
            buildContainer(
              ListView.builder(
                itemBuilder: (context, index) => Card(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Text(
                      selectedMeal.ingredients[index],
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
              200,
            ),
            buildWidget(context, 'Steps'),
            buildContainer(
              ListView.builder(
                itemBuilder: (context, index) => Column(
                  children: [
                    ListTile(
                      title: Text(selectedMeal.steps[index]),
                      leading: CircleAvatar(
                        child: Text('#${index + 1}'),
                      ),
                    ),
                    const Divider(),
                  ],
                ),
                itemCount: selectedMeal.steps.length,
              ),
              250,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: isMealFavorite(mealId)
            ? const Icon(Icons.star)
            : const Icon(Icons.star_border),
        onPressed: () {
          //Navigator.of(context).pop(mealId);
          toggelFavoriteMeal(mealId);
        },
      ),
    );
  }
}
