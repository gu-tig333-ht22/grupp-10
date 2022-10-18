import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';
import 'package:provider/provider.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meals';
  final List<Meal> list;
  CategoryMealsScreen(this.list);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            label: list[index].label,
            image: list[index].image,
            // calories: displayedMeals[index].calories,
            // affordability: displayedMeals[index].affordability,
            // complexity: displayedMeals[index].complexity,
          );
        },
        itemCount: list.length,
      ),
    );
  }
}
