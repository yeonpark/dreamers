import 'package:flutter/material.dart';
import 'package:mock_airbnb/aircategories.dart';
import 'package:mock_airbnb/airgrid.dart';

void main() {
  runApp(const SecondPage());
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

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
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 7,
                            blurStyle: BlurStyle.outer)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Icon(Icons.search, size: 25),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Where to go?',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text('Anywhere, Any week, Add guests',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ))
                          ],
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90),
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.3), width: 2),
                          ),
                          child: Icon(Icons.tune, size: 25),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Categories(
                        icon: Icons.window,
                        name: 'Amazing Views',
                      ),
                      Categories(
                        icon: Icons.domain,
                        name: 'Iconic cities',
                      ),
                      Categories(
                        icon: Icons.cottage,
                        name: 'Design',
                      ),
                      Categories(
                        icon: Icons.water,
                        name: 'Amazing pools',
                      ),
                      Categories(
                        icon: Icons.snowboarding,
                        name: 'Arctic',
                      ),
                      Categories(
                        icon: Icons.night_shelter_outlined,
                        name: 'Private rooms',
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(top: 0),
                  children: [
                    airGrids(
                      image: 'assets/images/thailand.jpeg',
                      address: 'Tambon Phaya Yen, Thailand',
                      view: 'Mountain views',
                      dates: '12-17 Feb, Individual Host',
                      price: '\$458',
                    ),
                    airGrids(
                      image: 'assets/images/vietnam.jpeg',
                      address: 'Thanh pho Nha Trang, Vietnam',
                      view: 'Ocean Views',
                      dates: '8-13 Feb, Individual Host',
                      price: '\$1065',
                    ),
                    airGrids(
                      image: 'assets/images/geoje.jpeg',
                      address: 'Geoje-myeon, Geoje-si, South Korea',
                      view: 'Sea Views',
                      dates: '13-18 Feb, Professional Host',
                      price: '\$442',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   type: BottomNavigationBarType.fixed,
        //   backgroundColor: Colors.white,
        //   selectedItemColor: Color(0xffff295d),
        //   unselectedItemColor: Colors.black.withOpacity(0.5),
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.search),
        //       label: 'Explore',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.favorite_border_outlined),
        //       label: 'Wishlists',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.logo_dev),
        //       label: 'Trips',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.textsms_outlined),
        //       label: 'Inbox',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.portrait),
        //       label: 'Profile',
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
