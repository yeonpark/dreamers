import 'package:flutter/material.dart';
import 'package:mock_airbnb/basic_info.dart';
import 'package:mock_airbnb/categories.dart';
import 'package:mock_airbnb/grid.dart';

void main() {
  runApp(const FirstPage());
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _MyAppState();
}

class _MyAppState extends State<FirstPage> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
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
              Container(
                //category bar
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Container(
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
      ),
    );
  }
}
