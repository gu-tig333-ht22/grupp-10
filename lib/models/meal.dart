import 'package:flutter/foundation.dart';
import '../fetcher/apiFetcher.dart';
import 'dart:developer';

class Meal {
  String label;
  String image;
  String source;
  List<String> ingredientLines;
  List<String> healthLabels;
  double calories;
  String url;

  Meal({
    this.label,
    this.source,
    this.image,
    this.healthLabels,
    this.ingredientLines,
    this.calories,
    this.url,
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
      url = json['url'];
    } catch (e) {}
  }
}

class MyState extends ChangeNotifier {
  List<Meal> _list = [];
  List<Meal> get list => _list;

  void searchMeals() async {
    var list = await Fetcher.searchRecipe(query, cusineType, filter);
    _list = list;
    notifyListeners();
  }

  MyState() {
    searchMeals();
  }

  String _filter = 'vegetarian';
  String get filter => _filter;

  String _query = '';
  String get query => _query;

  String _cuisineType = 'Asian';
  String get cusineType => _cuisineType;

  void updateFilter(String newValue) {
    _filter = newValue;
    notifyListeners();
  }
}
