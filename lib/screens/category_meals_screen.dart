import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';
import 'package:provider/provider.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meals';
  final List<Meal> list;
  final String cuisineType;
  final List<String> filter;
  CategoryMealsScreen(this.list, this.filter, this.cuisineType);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cuisineType),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            label: list[index].label,
            image: list[index].image,
            uri: list[index].uri,
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
