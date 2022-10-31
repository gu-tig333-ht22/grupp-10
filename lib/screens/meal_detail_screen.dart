import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import 'package:provider/provider.dart';
import '../models/meal.dart';
import '../models/state.dart';
import 'package:url_launcher/url_launcher.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  final MealItem selectedRecipe;
  final List<MealItem> favourites;

  MealDetailScreen(this.selectedRecipe, this.favourites);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<appState>(context, listen: false);

    // Get if this recipe is a favourite
    var isFavourite = state.isFavourite(selectedRecipe);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedRecipe.label),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedRecipe.image,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(selectedRecipe.ingredientLines[index])),
                ),
                itemCount: selectedRecipe.ingredientLines.length,
              ),
            ),
            Container(
                width: 240,
                decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(6.0),
                    color: Color.fromARGB(255, 255, 217, 0),
                    border: Border.all(color: Color.fromARGB(255, 50, 50, 51))),
                child: TextButton(
                  onPressed: () async {
                    if (await canLaunch(selectedRecipe.uri)) {
                      await launch(selectedRecipe.uri);
                    } else {
                      throw 'Could not launch url';
                    }
                  },
                  child: const Text(
                    'View Recipe',
                    style: TextStyle(
                        fontSize: 24,
                        color: Color.fromARGB(255, 37, 37, 37),
                        fontWeight: FontWeight.w400),
                  ),
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isFavourite == true ? Icons.star : Icons.star_border,
        ),
        onPressed: () => {
          isFavourite
              ? state.removeFavourite(selectedRecipe)
              : state.addFavourite(selectedRecipe)
        },
      ),
    );
  }
}
