import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<MealItem> favoriteMeals;

  FavoritesScreen(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text('You have no favorites yet - start adding some!'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
              label: favoriteMeals[index].label,
              image: favoriteMeals[index].image,
              uri: favoriteMeals[index].uri,
              calories: favoriteMeals[index].calories,
              totalTime: favoriteMeals[index].totalTime,
              source: favoriteMeals[index].source);
        },
        itemCount: favoriteMeals.length,
      );
    }
  }
}
