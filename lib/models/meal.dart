import 'package:flutter/foundation.dart';
import '../fetcher.dart';
import 'dart:developer';
import '../widgets/meal_item.dart';

class Meal {
  String label;
  String image;
  String source;
  List<String> ingredientLines;
  List<String> healthLabels;
  double calories;
  String uri;

  Meal({
    this.label,
    this.source,
    this.image,
    this.healthLabels,
    this.ingredientLines,
    this.calories,
    this.uri,
  });

  Meal.fromJson(Map<String, dynamic> json) {
    try {
      json = json['recipe'];
      label = json['label'];
      source = json['source'];
      image = json['image'];
      healthLabels = new List<String>.from(json['healthLabels']);
      ingredientLines = new List<String>.from(json['ingredientLines']);
      calories = json['calories'];
      uri = json['uri'];
    } catch (e) {
      //do nothing
    }
  }
}

class MyState extends ChangeNotifier {
  List<Meal> _list = [];
  List<Meal> get list => _list;

  String _query = '';
  String get query => _query;
  String _cuisineType = 'Asian';
  String get cuisineType => _cuisineType;
  List<String> _filter = ['vegetarian', 'vegan'];
  List<String> get filter => _filter;

  void searchMeals() async {
    var list = await Fetcher.searchRecipe(query, cuisineType, filter);
    _list = list;
    notifyListeners();
  }

  void updateCuisineType(inputCuisineType) async {
    if (inputCuisineType != cuisineType) {
      _cuisineType = inputCuisineType;
      notifyListeners();
      await searchMeals();
    }
  }

  MyState() {
    searchMeals();
  }

  MealItem _selectedRecipe = null;
  MealItem get selectedRecipe => _selectedRecipe;

  void setSelectedRecipe(uri) async {
    const startWord = "recipe_";
    final startIndex = uri.indexOf(startWord);
    final String id = uri.substring(startIndex + startWord.length, uri.length);

    var _fetchedMeal = await Fetcher.fetchRecipe(id);
    _selectedRecipe = _fetchedMeal;
    debugPrint(_selectedRecipe.toString());
    notifyListeners();
  }

  // void updateFilter(String newValue) {
  //   notifyListeners();
  // }
}
