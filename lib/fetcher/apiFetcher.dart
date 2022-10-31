import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/meal.dart';
import '../widgets/meal_item.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Fetcher {
  static Future searchRecipe(query, cuisineType, filters) async {
    // Build filter "health" string (vegan, vegetarian etc).
    var filterString = filters.join('&health=');

    var base_url =
        'https://api.edamam.com/api/recipes/v2?type=public&app_id=${dotenv.env['APP_ID']}&app_key=${dotenv.env['APP_KEY']}&imageSize=THUMBNAIL&field=label&field=image&field=source&field=healthLabels&field=ingredientLines&field=calories&field=uri&field=totalTime';
    http.Response response = await http.get(Uri.parse(
        '${base_url}&q=${query}&cuisineType=${cuisineType}&health=${filterString}'));
    if (response.statusCode == 200) {
      var _jsonData = response.body;
      final List parsedList = json.decode(_jsonData)['hits'];
      List<Meal> list = parsedList.map((val) => Meal.fromJson(val)).toList();
      return list;
    } else {
      print("API request failed.");
      final List<Meal> emptyResp = [];
      return emptyResp;
    }
  }

  static Future fetchRecipe(id) async {
    var recipe_url =
        'https://api.edamam.com/api/recipes/v2/${id}?type=public&app_id=${dotenv.env['APP_ID']}&app_key=${dotenv.env['APP_KEY']}&field=uri&field=label&field=image&field=images&field=source&field=url&field=healthLabels&field=ingredientLines&field=calories&field=cuisineType&field=totalTime';
    http.Response response = await http.get(Uri.parse(recipe_url));
    if (response.statusCode == 200) {
      var _jsonData = response.body;
      var _jsonDecoded = json.decode(_jsonData);
      MealItem parsedObject = MealItem.fromJson(_jsonDecoded);
      return parsedObject;
    } else {
      print("API request failed.");
      final MealItem emptyResp = null;
      return emptyResp;
    }
  }
}
