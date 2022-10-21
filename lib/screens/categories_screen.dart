import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../models/category.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  TextEditingController textkontroll = TextEditingController();

  static List<Category> DUMMY_CATEGORIES = [
    Category(
      id: 'c1',
      title: 'Italian',
      color: Colors.purple,
    ),
    Category(
      id: 'c2',
      title: 'Quick & Easy',
      color: Colors.red,
    ),
    Category(
      id: 'c3',
      title: 'Hamburgers',
      color: Colors.orange,
    ),
    Category(
      id: 'c4',
      title: 'German',
      color: Colors.amber,
    ),
    Category(
      id: 'c5',
      title: 'Light & Lovely',
      color: Colors.blue,
    ),
    Category(
      id: 'c6',
      title: 'Exotic',
      color: Colors.green,
    ),
    Category(
      id: 'c7',
      title: 'Breakfast',
      color: Colors.lightBlue,
    ),
    Category(
      id: 'c8',
      title: 'Asian',
      color: Colors.lightGreen,
    ),
    Category(
      id: 'c9',
      title: 'French',
      color: Colors.pink,
    ),
    Category(
      id: 'c10',
      title: 'Summer',
      color: Colors.teal,
    ),
  ];

  void updateList(String value) {
    setState(() {
      display_list = DUMMY_CATEGORIES
          .where(
            (element) => element.title.toLowerCase().contains(
                  value.toLowerCase(),
                ),
          )
          .toList();

      display_list
        ..sort((Category a, Category b) {
          int indexOfelementInA = a.title.indexOf(value);
          int indexOfelementInB = b.title.indexOf(value);
          if (indexOfelementInA < indexOfelementInB)
            return -1;
          else
            return 1;
        });
    });
  }
  /*
  void updateList(String value) {
    setState(() {
      display_list = DUMMY_CATEGORIES
          .where(
            (element) => element.title.toLowerCase().contains(
                  value.toLowerCase(),
                ),
          )
          .toList();
    });
  }
  */

  List<Category> display_list =
      List.from(_CategoriesScreenState.DUMMY_CATEGORIES);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onChanged: (value) => updateList(value),
                controller: textkontroll,
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'sök ...',
                  hintStyle: TextStyle(fontSize: 22),
                  prefixIcon: Icon(Icons.search, size: 28),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                  child: display_list.length == 0
                      ? Center(
                          child: Text(
                            'Inga resultat funna ..',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      : GridView(
                          padding: const EdgeInsets.all(25),
                          children: display_list
                              .map(
                                (catData) => CategoryItem(
                                  catData.id,
                                  catData.title,
                                  catData.color,
                                ),
                              )
                              .toList(),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                        ))
            ]));
  }
}
