import 'package:flutter/foundation.dart';
import '../fetcher/apiFetcher.dart';
import 'dart:developer';
import 'meal.dart';
import '../widgets/meal_item.dart';

class appState extends ChangeNotifier {
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

  appState() {
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

  List<MealItem> _favourites = [];
  List<MealItem> get favourites => _favourites;
  void addFavourite(recipe) async {
    _favourites.insert(0, recipe);
    debugPrint(_favourites.toString());
    notifyListeners();
  }

  void removeFavourite(recipe) async {
    for (var i = 0; i < _favourites.length; i++) {
      if (_favourites[i].uri == recipe.uri) {
        _favourites.removeAt(i);
      }
    }
    notifyListeners();
  }

  bool isFavourite(recipe) {
    for (var favourite in _favourites) {
      if (favourite.uri == recipe.uri) {
        return true;
      }
    }
    return false;
  }
}
