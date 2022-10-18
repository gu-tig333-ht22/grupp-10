import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/meal.dart';
import 'package:flutter/foundation.dart';

class Fetcher {
  static Future searchRecipe(query, cuisineType, filters) async {
    var base_url =
        'https://api.edamam.com/api/recipes/v2?type=public&app_id=607e9ef0&app_key=36dd52ad40a313ff492876bb59038867%09&imageSize=SMALL&field=label&field=image&field=source&field=healthLabels&field=ingredientLines&field=calories&field=url';
    http.Response response = await http.get(Uri.parse(
        '${base_url}&q=${query}&cuisineType=${cuisineType}&health=${filters}'));
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
}
