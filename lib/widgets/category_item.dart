import 'package:flutter/material.dart';
import '../screens/category_meals_screen.dart';
import 'package:provider/provider.dart';
import '../models/state.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final String image;

  CategoryItem(this.id, this.title, this.image);

  Future<void> selectCategory(BuildContext ctx) async {
    var state = await Provider.of<appState>(ctx, listen: false);
    await state.updateCuisineType(title);

    await Navigator.of(ctx).pushNamed(
      CategoryMealsScreen.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.only(top: 80),
        child: GridTileBar(
          backgroundColor: Colors.blueGrey,
          title: Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.all(Radius.circular(20)),
          image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(image)),
        ),
      ),
    );
  }
}
