import 'package:flutter/material.dart';
import '../firstpage/categories.dart';
import '../firstpage/grid.dart';
import '../test_data/success_info.dart';
/*
This is item list page, set it as a mainpage just for test.
Scaffold consisted of body only.
Under body, it has search bar, cateogries, and listview.
Listview is consisted of containers which is wrapped by GestureDetector,
which ables clicking the containers to navigate to Yeon's itempage. 
*/

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
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
                      position: 0,
                    ),
                    Categories(
                      icon: Icons.child_care,
                      name: 'Primary/Secondary',
                      position: 1,
                    ),
                    Categories(
                      icon: Icons.school_outlined,
                      name: 'Teritary',
                      position: 2,
                    ),
                    Categories(
                      icon: Icons.female_outlined,
                      name: 'Female',
                      position: 3,
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
                    image: 'assets/images/yeon.jpg',
                    field: 'Computer Science',
                    name: successInfo[0].name,
                    nationality: 'Malaysia',
                    sentences:
                        'Hi, i am Yeon Park from Malaysia. I like laksa.',
                  ),
                  Grids(
                    image: 'assets/images/sung.jpg',
                    field: 'Computer Engineering',
                    name: 'Sung Huh',
                    nationality: 'China',
                    sentences:
                        'Hi, I am Sung Huh from China. I like beijing duck.',
                  ),
                  Grids(
                    image: 'assets/images/hailey.jpg',
                    field: 'Electrical engineering and computer science',
                    name: 'Jeff Bezos',
                    nationality: 'United States of America',
                    sentences: 'Hi, I am Jeff Beozs form America.',
                  ),
                  Grids(
                    image: 'assets/images/joon.jpg',
                    field: 'Business Administration',
                    name: 'Warren Buffett',
                    nationality: 'United States of America',
                    sentences:
                        'Hi, I am Warren Buffet form America. I want to be rich.',
                  ),
                  Grids(
                    image: 'assets/images/virgil.jpeg',
                    field: 'Industrial Engineering',
                    name: 'Kim Bum-Soo',
                    nationality: 'Republic of Korea',
                    sentences: 'Hi, I am Bum-soo Kim form South Korea.',
                  ),
                  Grids(
                    image: 'assets/images/salah.jpg',
                    field: 'Industrial Engineering',
                    name: 'Kim Bum-Soo',
                    nationality: 'Republic of Korea',
                    sentences: 'Hi, I am Bum-soo Kim form South Korea.',
                  ),
                  Grids(
                    image: 'assets/images/gerrard.jpg',
                    field: 'Industrial Engineering',
                    name: 'Kim Bum-Soo',
                    nationality: 'Republic of Korea',
                    sentences: 'Hi, I am Bum-soo Kim form South Korea.',
                  ),
                  Grids(
                    image: 'assets/images/klopp.jpg',
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



// Expanded(
//               child: ListView(
//                 padding: EdgeInsets.only(top: 0),
//                 children: [
//                   Grids(
//                     image: 'assets/images/yeon.jpg',
//                     field: 'Computer Science',
//                     name: successInfo[0].name,
//                     nationality: 'Malaysia',
//                     sentences:
//                         'Hi, i am Yeon Park from Malaysia. I like laksa.',
//                   ),
//                   Grids(
//                     image: 'assets/images/sung.jpg',
//                     field: 'Computer Engineering',
//                     name: 'Sung Huh',
//                     nationality: 'China',
//                     sentences:
//                         'Hi, I am Sung Huh from China. I like beijing duck.',
//                   ),
//                   Grids(
//                     image: 'assets/images/hailey.jpg',
//                     field: 'Electrical engineering and computer science',
//                     name: 'Jeff Bezos',
//                     nationality: 'United States of America',
//                     sentences: 'Hi, I am Jeff Beozs form America.',
//                   ),
//                   Grids(
//                     image: 'assets/images/joon.jpg',
//                     field: 'Business Administration',
//                     name: 'Warren Buffett',
//                     nationality: 'United States of America',
//                     sentences:
//                         'Hi, I am Warren Buffet form America. I want to be rich.',
//                   ),
//                   Grids(
//                     image: 'assets/images/virgil.jpeg',
//                     field: 'Industrial Engineering',
//                     name: 'Kim Bum-Soo',
//                     nationality: 'Republic of Korea',
//                     sentences: 'Hi, I am Bum-soo Kim form South Korea.',
//                   ),
//                   Grids(
//                     image: 'assets/images/salah.jpg',
//                     field: 'Industrial Engineering',
//                     name: 'Kim Bum-Soo',
//                     nationality: 'Republic of Korea',
//                     sentences: 'Hi, I am Bum-soo Kim form South Korea.',
//                   ),
//                   Grids(
//                     image: 'assets/images/gerrard.jpg',
//                     field: 'Industrial Engineering',
//                     name: 'Kim Bum-Soo',
//                     nationality: 'Republic of Korea',
//                     sentences: 'Hi, I am Bum-soo Kim form South Korea.',
//                   ),
//                   Grids(
//                     image: 'assets/images/klopp.jpg',
//                     field: 'Industrial Engineering',
//                     name: 'Kim Bum-Soo',
//                     nationality: 'Republic of Korea',
//                     sentences: 'Hi, I am Bum-soo Kim form South Korea.',
//                   ),
//                 ],
//               ),
//             ),

