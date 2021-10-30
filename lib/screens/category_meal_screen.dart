import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealScreen extends StatefulWidget {
  static const String routeName = '/category_meals';
  final List<Meal> availabileMeals;
  const CategoryMealScreen(this.availabileMeals, {Key? key}) : super(key: key);
  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String? categoryTitle;
  late List<Meal> categoryMeals;

  @override
  void didChangeDependencies() {
    final routeArg =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final categoryId = routeArg['id'];
    categoryTitle = routeArg['title'];
    categoryMeals = widget.availabileMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  // void initState() {
  //   super.initState();
  // }

  void removeMeal(String mealId) {
    setState(
        () => categoryMeals.removeWhere((element) => element.id == mealId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryTitle!,
          textAlign: TextAlign.right,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            id: categoryMeals[index].id,
            title: categoryMeals[index].title,
            duration: categoryMeals[index].duration,
            complexity: categoryMeals[index].complexity,
            affordability: categoryMeals[index].affordability,
            imagUrl: categoryMeals[index].imageUrl,
            //removeItem: removeMeal,
          );
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
