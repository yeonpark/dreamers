import 'package:mock_airbnb/category_listview.dart';
import 'package:flutter/material.dart';
import 'package:mock_airbnb/basic_info.dart';
import 'package:percent_indicator/percent_indicator.dart';
//import 'package:carousel_slider/carousel_slider.dart';
import 'package:mock_airbnb/carousel_slider.dart';
import 'package:mock_airbnb/grid.dart';

void main() {
  runApp(const OnClickPerson());
}

class OnClickPerson extends StatelessWidget {
  const OnClickPerson({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromARGB(255, 236, 171, 193),
          //secondary: Colors.green,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color(0xFF232B55),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final double goalPercentage = 40;

  int selectedIndex = 0;
  int index = 0;

  // Required for the carousel slider widget from pub.dev
  /*
  List<String> images = [
    "https://images.wallpapersden.com/image/download/purple-sunrise-4k-vaporwave_bGplZmiUmZqaraWkpJRmbmdlrWZlbWU.jpg",
    "https://wallpaperaccess.com/full/2637581.jpg",
    "https://uhdwallpapers.org/uploads/converted/20/01/14/the-mandalorian-5k-1920x1080_477555-mm-90.jpg"
  ];

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: const EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.black26,
            shape: BoxShape.circle),
      );
    });
  }
  */

  // Buttons for caurosel slider of the Description
  List category = ['Summary', 'Full Story', 'Person Detail'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,

          // Maybe can be used as button to go back to the home page?
          leading: IconButton(
            icon: Image.asset('assets/images/logo.png'),
            onPressed: () {},
          ),

          // Location of the search bar
          title: const Center(
            child: Text(
              "Search bar",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),

          // Need the name of the icon used in the ui mock up
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.person_2_outlined,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(15),
              child: BasicInfo(
                title: 'Title',
                postdate: '01/01/29',
                name: 'Name',
                country: 'Country',
              ),
            ),

            // In the future, the input parameter will be the images to be displayed
            const CarouselSliderManual(),

            // I don't know how to add an indicator here
            /*
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                viewportFraction: 1,
              ),
              items: [0, 1, 2].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      //margin: EdgeInsets.symmetric(horizontal: 5.0),
                      //decoration: BoxDecoration(color: Colors.amber),
                      child: Image.network(
                        images[i],
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            */

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: <Widget>[
                  const Text('Goal (%)'),
                  const SizedBox(width: 5),
                  LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width * 0.78,
                    lineHeight: 20.0,
                    animationDuration: 2500,
                    percent: goalPercentage / 100,
                    center: Text("$goalPercentage%"),
                    barRadius: const Radius.circular(45),
                    progressColor: const Color.fromARGB(255, 210, 155, 173),
                  ),
                ],
              ),
            ),

            Stack(
              children: [
                ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 30,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: category.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(left: 18),
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            decoration: BoxDecoration(
                              color: index == selectedIndex
                                  ? Colors.deepOrangeAccent
                                  : Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Text(
                              category[index],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    /* In future, when each widgets corresponding to the button have
                    different contents, if statement can be applied here */
                    CategoryListView(index: selectedIndex),
                  ],
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      fixedSize: const MaterialStatePropertyAll(
                        Size.fromWidth(340),
                      ),
                      textStyle: const MaterialStatePropertyAll(TextStyle(
                        fontSize: 20,
                      )),
                      backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 210, 155, 173),
                      )),
                  child: const Text(
                    'Donate Now',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
          ),
        ));
  }
}
