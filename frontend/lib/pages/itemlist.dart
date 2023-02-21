import 'package:flutter/material.dart';
import '../firstpage/categories.dart';
import '../firstpage/grid.dart';
/*
This is item list page, set it as a mainpage just for test.
Scaffold consisted of body only.
Under body, it has search bar, cateogries, and listview.
Listview is consisted of containers which is wrapped by GestureDetector,
which ables clicking the containers to navigate to Yeon's itempage. 
*/

class ItemList extends StatefulWidget {
  const ItemList({super.key});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  // This widget is the main page of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 7,
                          blurStyle: BlurStyle.outer)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Row(
                    children: [
                      Icon(Icons.search, size: 20, color: Colors.red),
                      SizedBox(width: 20),
                      Text(
                        'Find your dreamers',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              //category bar
              height: 70,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Categories(
                      icon: Icons.timer_sharp,
                      name: 'Last Minute',
                    ),
                    Categories(
                      icon: Icons.child_care,
                      name: 'Primary/Secondary',
                    ),
                    Categories(
                      icon: Icons.school_outlined,
                      name: 'Teritary',
                    ),
                    Categories(
                      icon: Icons.female_outlined,
                      name: 'Female',
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 0),
                children: [
                  Grids(
                    image: 'assets/images/stevejobs.jpeg',
                    field: 'Computer Science',
                    name: 'Steve Jobs',
                    nationality: 'United States of America',
                    sentences:
                        'Hi, i am Steve Jobs from America. I like apple.',
                  ),
                  Grids(
                    image: 'assets/images/elon.webp',
                    field: 'Science',
                    name: 'Elon Musk',
                    nationality: 'South Africa',
                    sentences:
                        'Hi, I am Elon musk from South Africa. I want to go to Mars.',
                  ),
                  Grids(
                    image: 'assets/images/jeff.webp',
                    field: 'Electrical engineering and computer science',
                    name: 'Jeff Bezos',
                    nationality: 'United States of America',
                    sentences: 'Hi, I am Jeff Beozs form America.',
                  ),
                  Grids(
                    image: 'assets/images/buffett.jpeg',
                    field: 'Business Administration',
                    name: 'Warren Buffett',
                    nationality: 'United States of America',
                    sentences:
                        'Hi, I am Warren Buffet form America. I want to be rich.',
                  ),
                  Grids(
                    image: 'assets/images/bumsoo.jpeg',
                    field: 'Industrial Engineering',
                    name: 'Kim Bum-Soo',
                    nationality: 'Republic of Korea',
                    sentences: 'Hi, I am Bum-soo Kim form South Korea.',
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
