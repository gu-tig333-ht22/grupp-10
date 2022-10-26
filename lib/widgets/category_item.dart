import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/dummy_data.dart';
import '../models/category.dart';
import '../screens/category_meals_screen.dart';
import 'package:provider/provider.dart';
import '../models/meal.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;
  final String image;

  CategoryItem(this.id, this.title, this.color, this.image);

  Future<void> selectCategory(BuildContext ctx) async {
    var state = await Provider.of<MyState>(ctx, listen: false);
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
          title: Center(
            child: Text(
              title,
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(1.0, 1.0), //position of shadow
                      blurRadius: 1.0, //blur intensity of shadow
                      color: Colors.grey
                          .withOpacity(0.3), //color of shadow with opacity
                    ),
                  ]),
            ),
          ),
        ),
        decoration: BoxDecoration(
          image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(image)),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
