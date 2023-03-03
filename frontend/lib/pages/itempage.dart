import 'package:flutter/material.dart';
//import 'package:dreamers/itempage_widget/card_swiper.dart';
import '../test_data/success_info.dart';
import 'package:card_swiper/card_swiper.dart';
import '../pages/search_page.dart';
import '../constants/colors.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/popup_card.dart';
//import 'itemlist.dart';

class ItemPage extends StatefulWidget {
  final SuccessInfo successInfo;
  final void Function() parentAction;
  const ItemPage({
    super.key,
    required this.parentAction,
    required this.successInfo,
  });

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  int index = 0;
  int selectedIndex = 0;

  List category = ['Profile', 'Details', 'Vision'];

  //final GlobalKey<ItemListState> _keyParent = GlobalKey();
  // void updateLike() {
  //   setState(() {
  //     return widget.parentAction();
  //   });
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
        body: SafeArea(
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: Row(
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                    ),
                    Center(
                      child: Text(
                        widget.successInfo.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => const SearchPage())),
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 4,
                child: Stack(
                  children: [
                    // BasicInfo(
                    //   title: 'Title',
                    //   postdate: 'Posted Date',
                    //   name: 'Name',
                    //   country: 'Country',
                    // ),

                    // In the future, the input parameter will be the images to be displayed
                    //const CarouselSliderManual(),
                    CardSwiper(images: widget.successInfo.images),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                      child: Align(
                        alignment: Alignment.topRight,
                        // right: MediaQuery.of(context).size.width - 700,
                        // top: 10,
                        child: InkWell(
                          child: widget.successInfo.category
                                  .contains('wishlist')
                              ? Icon(Icons.favorite, color: Color(0xfffca5a5))
                              : Icon(Icons.favorite_border,
                                  color: Color(0xfffca5a5)),
                          onTap: () => setState(
                            () {
                              widget.parentAction();
                              //if (widget.successInfo) {
                              //_keyParent.currentState.toggleFavorite();
                              //}
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Widget adopted from pub.dev <percent_indicator 4.2.2>
              Flexible(
                flex: 5,
                child: Column(
                  children: [
                    // Need to use the varying selectedIndex value in CategoryListView
                    // To take this widget out but stuck with notifying the value change
                    // Made in below widget
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: category.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              //margin: const EdgeInsets.only(left: 18),
                              //padding: const EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width /
                                  category.length,
                              //height: 20,
                              decoration: BoxDecoration(
                                color: index == selectedIndex
                                    ? primaryColor
                                    : gradientStartColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: titleTextColor.withOpacity(0.7),
                                    blurRadius: 2.0,
                                    spreadRadius: 0.5,
                                    offset: Offset(0.0,
                                        5.0), // shadow direction: bottom right
                                  )
                                ],
                                // boxShadow: [
                                //   BoxShadow(
                                //     //color: neutralColor.withOpacity(0.8),
                                //     color: index == selectedIndex
                                //         ? primaryColor
                                //         : navigationColor,
                                //     spreadRadius: 5,
                                //     blurRadius: 10,
                                //     offset: Offset(
                                //         0, 3), // changes position of shadow
                                //   ),
                                // ],
                                // borderRadius: BorderRadius.circular(40),
                              ),
                              child: Text(
                                category[index],
                                style: TextStyle(color: contentTextColor),
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
                      flex: 5,
                      child: CategoryListView(index: selectedIndex),
                    ),
                    Flexible(
                      flex: 1,
                      child: PercentBar(
                        goalPercentage: widget.successInfo.goalPercentage,
                      ),
                    ),
                  ],
                ),
              ),

              // Why stack used?
            ],
          ),
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
  final List<String> images;
  const CardSwiper({
    super.key,
    required this.images,
  });

  // List<String> images = widget.successInfo.images;
  @override
  Widget build(BuildContext context) {
    return Swiper(
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
          images[index],
          fit: BoxFit.fill,
        );
      },
      itemCount: images.length,
      //control: SwiperControl(),
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
  // double goalPercentage = 1;
  // @override
  // void initState() {
  //   super.initState();
  // }

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
                  //percent: ((widget.goalPercentage != null) ? widget.goalPercentage : 0)/ 100,
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

// class BasicInfo extends StatelessWidget {
//   final String title;
//   final String postdate;
//   final String name;
//   final String country;

//   const BasicInfo({
//     super.key,
//     required this.title,
//     required this.postdate,
//     required this.name,
//     required this.country,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(15),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       color: Colors.black,
//                       fontSize: 28,
//                       fontWeight: FontWeight.w800,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         postdate,
//                         style: TextStyle(
//                           color: Colors.black.withOpacity(0.8),
//                           fontSize: 18,
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         name,
//                         style: TextStyle(
//                           color: Colors.black.withOpacity(0.8),
//                           fontSize: 18,
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         country,
//                         style: TextStyle(
//                           color: Colors.black.withOpacity(0.8),
//                           fontSize: 18,
//                         ),
//                       ),
//                     ],
//                   ),
//                   // const SizedBox(
//                   //   height: 20,
//                   // ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
