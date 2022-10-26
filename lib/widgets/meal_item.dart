import 'package:flutter/material.dart';

import '../screens/meal_detail_screen.dart';
import '../models/meal.dart';
import 'package:provider/provider.dart';

class MealItem extends StatelessWidget {
  String label;
  String image;
  String source;
  String uri;
  double calories;
  double totalTime;
  List<String> ingredientLines;

  MealItem(
      {this.label,
      this.image,
      this.source,
      this.uri,
      this.calories,
      this.ingredientLines,
      this.totalTime});

  MealItem.fromJson(Map<String, dynamic> json) {
    try {
      json = json['recipe'];
      label = json['label'];
      source = json['source'];
      uri = json['uri'];
      image = json['image'];
      // healthLabels = new List<String>.from(json['healthLabels']);
      ingredientLines = new List<String>.from(json['ingredientLines']);
      calories = json['calories'];
      totalTime = json['totalTime'];
    } catch (e) {
      //do nothing
    }
  }

  void selectMeal(BuildContext ctx, uri) async {
    var state = await Provider.of<MyState>(ctx, listen: false);
    await state.setSelectedRecipe(uri);

    await Navigator.of(ctx)
        .pushNamed(MealDetailScreen.routeName)
        .then((result) {
      if (result != null) {
        // removeItem(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context, uri),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    image,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.addchart,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                          calories != null
                              ? calories.toStringAsFixed(0) + ' cal'
                              : 'Unknown',
                          style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.cabin,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(source != null ? source : 'Unknown',
                          style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.more_time,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                          totalTime != null && totalTime != 0
                              ? totalTime.toStringAsFixed(0) + ' min'
                              : 'Unknown',
                          style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
