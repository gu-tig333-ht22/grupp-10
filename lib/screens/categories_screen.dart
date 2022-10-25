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
        image:
            'https://upload.wikimedia.org/wikipedia/en/thumb/0/03/Flag_of_Italy.svg/255px-Flag_of_Italy.svg.png'),
    Category(
        id: 'c2',
        title: 'French',
        color: Colors.red,
        image:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/6/62/Flag_of_France.png/1024px-Flag_of_France.png'),
    Category(
        id: 'c3',
        title: 'Asian',
        color: Colors.orange,
        image:
            'https://fvmstatic.s3.amazonaws.com/maps/m/WRLD-AS-02-4001.png'),
    Category(
        id: 'c4',
        title: 'Indian',
        color: Colors.amber,
        image:
            'https://cdn.britannica.com/97/1597-004-05816F4E/Flag-India.jpg'),
    Category(
        id: 'c5',
        title: 'Japanese',
        color: Colors.blue,
        image:
            'https://upload.wikimedia.org/wikipedia/en/thumb/9/9e/Flag_of_Japan.svg/1200px-Flag_of_Japan.svg.png'),
    Category(
        id: 'c6',
        title: 'Greek',
        color: Colors.green,
        image:
            'https://cdn.britannica.com/49/1049-004-AE4BAD3E/Flag-Greece.jpg'),
    Category(
        id: 'c7',
        title: 'Mexican',
        color: Colors.lightBlue,
        image:
            'https://cdn.britannica.com/73/2573-004-29818847/Flag-Mexico.jpg'),
    Category(
        id: 'c8',
        title: 'Nordic',
        color: Colors.lightGreen,
        image:
            'https://scandification.com/wp-content/uploads/2021/06/What-Is-The-Nordic-Cross-1-scaled.jpg'),
    Category(
        id: 'c9',
        title: 'Caribbean',
        color: Colors.pink,
        image:
            'https://thumbs.dreamstime.com/b/caribbean-flags-d-map-embedded-national-blue-political-globe-illustration-130262859.jpg'),
    Category(
        id: 'c10',
        title: 'World',
        color: Colors.teal,
        image:
            'https://cdn3.vectorstock.com/i/1000x1000/16/62/earth-vector-35341662.jpg'),
  ];
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
  */
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
                  hintText: 'search ...',
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
                            'No Results Found ..',
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
                                    catData.image),
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
