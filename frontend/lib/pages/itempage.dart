import 'package:flutter/material.dart';
import 'package:dreamers/itempage_widget/basic_info.dart';
//import 'package:dreamers/itempage_widget/card_swiper.dart';
import 'package:dreamers/itempage_widget/appbar.dart';
import 'package:dreamers/itempage_widget/donate_button.dart';
import 'package:dreamers/itempage_widget/percent_bar.dart';
import 'package:dreamers/itempage_widget/category_listview.dart';
import '../test_data/success_info.dart';
import 'package:card_swiper/card_swiper.dart';

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
        appBar: CommonAppBar(),
        body: Column(
          children: [
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  BasicInfo(
                    title: 'Title',
                    postdate: 'Posted Date',
                    name: 'Name',
                    country: 'Country',
                  ),

                  // In the future, the input parameter will be the images to be displayed
                  //const CarouselSliderManual(),
                  CardSwiper(successInfo: successInfo[0]),
                ],
              ),
            ),
            // Widget adopted from pub.dev <percent_indicator 4.2.2>
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: PercentBar(
                      goalPercentage: 60,
                    ),
                  ),
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
                    child: DonateButton(),
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
            // builder: DotSwiperPaginationBuilder(
            //   color: Colors.black26,
            //   activeColor: Colors.deepOrangeAccent,
            //   // size: 6.0,
            //   // activeSize: 9.0,
            // ),
            ),
        itemBuilder: (context, index) {
          return Image.network(
            successInfo.images[index],
            fit: BoxFit.fill,
          );
        },
        itemCount: successInfo.images.length,
        control: SwiperControl(),
      ),
    );
  }
}
