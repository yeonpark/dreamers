import 'package:dreamers/features/search/screens/search_screen.dart';
import 'package:dreamers/features/story/screens/post_payment_screen.dart';
import 'package:dreamers/features/story/services/like_unlike_story.dart';
import 'package:dreamers/features/story/widgets/card_swiper.dart';
import 'package:dreamers/features/story/widgets/percent_bar.dart';
import 'package:dreamers/models/story.dart';
import 'package:dreamers/providers/wishlist_provider.dart';
import 'package:flutter/material.dart';
//import 'package:dreamers/itempage_widget/card_swiper.dart';
//import '../test_data/success_info.dart';
import 'package:card_swiper/card_swiper.dart';
//import '../pages/search_page.dart';
//import '../constants/colors.dart';
//import 'package:google_fonts/google_fonts.dart';
//import 'itemlist.dart';
import 'package:dreamers/constants/global_variables.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../widgets/popup_card.dart';

class ItemPage extends StatefulWidget {
  static const String routeName = '/story-detail';
  final Story story;

  const ItemPage({
    //super.key,
    Key? key,
    //required this.parentAction,
    required this.story,
  }) : super(key: key);

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

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wishList = Provider.of<WishListProvider>(context).items;
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
                        widget.story.heading,
                        style: GoogleFonts.ubuntu(
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
                    // In the future, the input parameter will be the images to be displayed
                    //const CarouselSliderManual(),

                    CardSwiper(images: widget.story.images),
                    // CardSwiper(images: widget.story.images),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                      child: Align(
                        alignment: Alignment.topRight,
                        // right: MediaQuery.of(context).size.width - 700,
                        // top: 10,
                        child: InkWell(
                          child: wishList.contains(widget.story.id)
                              ? const Icon(Icons.favorite,
                                  color: Color(0xfffca5a5))
                              : const Icon(Icons.favorite_border,
                                  color: Color(0xfffca5a5)),
                          onTap: () => setState(
                            () {
                              wishList.contains(widget.story.id)
                                  ? LikeUnlikeStory(
                                          category: '',
                                          storyId: widget.story.id)
                                      .unlikeStory(context)
                                  : LikeUnlikeStory(
                                          category: '',
                                          storyId: widget.story.id)
                                      .likeStory(context);
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
                                      ? Pallete.primaryColor
                                      : Pallete.gradientStartColor
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: titleTextColor.withOpacity(0.7),
                                  //     blurRadius: 2.0,
                                  //     spreadRadius: 0.5,
                                  //     offset: const Offset(0.0,
                                  //         5.0), // shadow direction: bottom right
                                  //   )
                                  // ],
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     //color: neutralColor.withOpacity(0.8),
                                  //     color: index == selectedIndex
                                  //         ? primaryColor
                                  //         : navigationColor,
                                  //     spreadRadius: 5,
                                  //     //blurRadius: 10,
                                  //     offset: const Offset(
                                  //         0, 3), // changes position of shadow
                                  //   ),
                                  // ],
                                  //borderRadius: BorderRadius.circular(40),
                                  ),
                              child: Text(
                                category[index],
                                style: GoogleFonts.ubuntu(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
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
                      child: CategoryListView(
                          index: selectedIndex, story: widget.story),
                    ),
                    const Flexible(
                      flex: 1,
                      child: PercentBar(
                        goalPercentage: 50, //widget.story.goalPercentage,
                      ),
                    ),
                  ],
                ),
              ),

              // Why stack used?
            ],
          ),
        ),
      ),
    );
  }
}
