import 'package:flutter/material.dart';
//import 'package:dreamers/itempage_widget/card_swiper.dart';
import 'package:dreamers/itempage_widget/category_listview.dart';
import '../test_data/success_info.dart';
import 'package:card_swiper/card_swiper.dart';
import '../pages/search_page.dart';
import '../constants/colors.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemPage extends StatefulWidget {
  //final SuccessInfo successInfo;
  const ItemPage({
    super.key,
    //required this.successInfo,
  });

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  int index = 0;
  int selectedIndex = 0;

  List category = ['Profile', 'Details', 'Vision'];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Item Page',

      // We need to decide the ThemeData for the project
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSwatch().copyWith(
        //   primary: const Color.fromARGB(255, 236, 171, 193),
        //   //secondary: Colors.green,
        // ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // textTheme: const TextTheme(
        //   displayLarge: TextStyle(
        //     color: Color(0xFF232B55),
        //   ),
        // ),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,

          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),

          title: Center(
            child: Text(
              successInfo[0].name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          // Need the name of the icon used in the ui mock up
          actions: <Widget>[
            IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const SearchPage())),
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Flexible(
              flex: 3,
              child: Column(
                children: [
                  // BasicInfo(
                  //   title: 'Title',
                  //   postdate: 'Posted Date',
                  //   name: 'Name',
                  //   country: 'Country',
                  // ),

                  // In the future, the input parameter will be the images to be displayed
                  //const CarouselSliderManual(),
                  CardSwiper(successInfo: successInfo[0]),
                ],
              ),
            ),
            // Widget adopted from pub.dev <percent_indicator 4.2.2>
            Flexible(
              flex: 4,
              child: Column(
                children: [
                  // Need to use the varying selectedIndex value in CategoryListView
                  // To take this widget out but stuck with notifying the value change
                  // Made in below widget
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
                                  ? primaryColor
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
                  ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  /* In future, when each widgets corresponding to the button have
                  different contents, if statement can be applied here */
                  Flexible(
                    flex: 3,
                    child: CategoryListView(index: selectedIndex),
                  ),
                  Flexible(
                    flex: 1,
                    child: PercentBar(
                      goalPercentage: 90,
                    ),
                  ),
                ],
              ),
            ),

            // Why stack used?
          ],
        ),
        // bottomNavigationBar: Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        //   child: SizedBox(
        //     width: double.infinity,
        //     height: 56,
        //     child:
        //   ),
        // ),
      ),
    );
  }
}

class CardSwiper extends StatelessWidget {
  final SuccessInfo successInfo;
  const CardSwiper({
    super.key,
    required this.successInfo,
  });

  // List<String> images = widget.successInfo.images;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Swiper(
        indicatorLayout: PageIndicatorLayout.NONE,
        pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
              color: dotColor,
              activeColor: contentTextColor,
              activeSize: 12,
              space: 4),
        ),
        itemBuilder: (context, index) {
          return Image.network(
            successInfo.images[index],
            fit: BoxFit.fill,
          );
        },
        itemCount: successInfo.images.length,
        //control: SwiperControl(),
      ),
    );
  }
}

class PercentBar extends StatefulWidget {
  final double goalPercentage;

  PercentBar({
    super.key,
    required this.goalPercentage,
  });

  @override
  State<PercentBar> createState() => _PercentBarState();
}

class _PercentBarState extends State<PercentBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15),
          child: Material(
            child: InkWell(
              onTap: () {},
              // highlightColor: navigationColor,
              // overlayColor: MaterialStateProperty.all(
              //   navigationColor,
              // ),
              borderRadius: BorderRadius.all(
                Radius.circular(45),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                height: 40,
                child: LinearPercentIndicator(
                  padding: EdgeInsets.all(0),
                  backgroundColor: Colors.white,
                  //fillColor: primaryColor,
                  // Subtract 30 here because of padding of 15 on both left and right
                  // Additional 57 for the goal Text and 5 pixel sized box
                  // There are two ways, get the length of text and minus it or remove the text
                  width: MediaQuery.of(context).size.width - 32,
                  lineHeight: 35.0,
                  percent: widget.goalPercentage / 100,
                  // Have to discuss how to represent, with digit on or off
                  center: Text(
                    "Donate Now",
                    style: GoogleFonts.ubuntu(
                        color: titleTextColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 20),
                  ),
                  barRadius: const Radius.circular(45),
                  // Need change to color to theme color
                  progressColor: primaryColor,
                ),
              ),
            ),
          ),
        ),
        //const SizedBox(width: 5),
      ],
    );
  }
}
