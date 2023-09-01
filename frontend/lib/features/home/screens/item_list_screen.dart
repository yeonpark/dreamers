//import 'package:dreamers/pages/itempage.dart';
import 'package:dreamers/constants/flamingo_icons.dart';
import 'package:dreamers/constants/global_variables.dart';
import 'package:dreamers/features/story/services/like_unlike_story.dart';
import 'package:dreamers/features/home/services/story_load.dart';
import 'package:dreamers/models/story.dart';
import 'package:dreamers/providers/category_provider.dart';
import 'package:dreamers/providers/story_provider.dart';
import 'package:dreamers/providers/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dreamers/features/story/screens/story_detail.dart';
import 'package:http/http.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:google_fonts/google_fonts.dart';
/*
This is item list page, set it as a mainpage just for test.
Scaffold consisted of body only.
Under body, it has search bar, cateogries, and listview.
Listview is consisted of containers which is wrapped by GestureDetector,
which ables clicking the containers to navigate to Yeon's itempage.
*/

class ItemList extends StatefulWidget {
  static const String routeName = '/main-screen';
  const ItemList({Key? key}) : super(key: key);

  @override
  State<ItemList> createState() => ItemListState();
}

class ItemListState extends State<ItemList> {
  // This widget is the main page of the application. First Page after login.
  static String _category = 'primary';

  void navigateToStoryDetails(BuildContext context, Story model) {
    Navigator.pushNamed(context, ItemPage.routeName, arguments: model);
  }

  @override
  void dispose() {
    super.dispose();
  }

  // GlobalKey<ItemPageState> _keyItemPage = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final story = Provider.of<StoryProvider>(context).items;
    final wishList = Provider.of<WishListProvider>(context).items;

    final categoryProvider = Provider.of<CategoryProvider>(context);

    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          // onTap: () => Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (_) => const SearchPage(),
                          //   ),
                          // ),
                          child: Container(
                            height: 45,
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Flamingo.logoSearch,
                                    size: 20,
                                    color: Colors.red,
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    'Find your dreamer...',
                                    // style: GoogleFonts.ubuntu(
                                    //   fontSize: 13,
                                    //   color: Colors.grey,
                                    // ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              flex: 1,
                              child: CategoryButton(
                                icon: Icons.timer_sharp,
                                name: 'Last Minute',
                                onPressed: () {
                                  categoryProvider.setCategory('primary');
                                  setState(() {
                                    _category = 'primary';
                                  });
                                  LoadStory(category: categoryProvider.category)
                                      .loadAllStory(context);

                                  //final story = Provider.of<MyProvider>(context).items;
                                },
                                selected: 'primary',
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: CategoryButton(
                                icon: Icons.child_care,
                                name: 'Primary/Secondary',
                                onPressed: () {
                                  categoryProvider.setCategory('secondary');
                                  setState(() {
                                    _category = 'secondary';
                                  });
                                  LoadStory(category: categoryProvider.category)
                                      .loadAllStory(context);

                                  //final story = Provider.of<MyProvider>(context).items;
                                },
                                // =>
                                //     setState(() => _category = 'secondary'),
                                selected: 'secondary',
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: CategoryButton(
                                icon: Icons.school_outlined,
                                name: 'Tertiary',
                                onPressed: () {
                                  const LoadStory(category: 'tertiary')
                                      .loadAllStory(context);
                                  categoryProvider.setCategory('tertiary');
                                  setState(() {
                                    _category = 'tertiary';
                                  });
                                  //final story = Provider.of<MyProvider>(context).items;
                                },
                                selected: 'tertiary',
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: CategoryButton(
                                icon: Icons.shopping_cart_outlined,
                                name: 'Wish List',
                                onPressed: () {
                                  const LoadStory(category: 'wishlist')
                                      .loadWishStory(context);
                                  categoryProvider.setCategory('wishlist');
                                  setState(() {
                                    _category = 'wishlist';
                                  });
                                  //final story = Provider.of<MyProvider>(context).items;
                                },
                                selected: 'wishlist',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Flexible(
                flex: 5,
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                    itemCount: story.length,
                    itemBuilder: (ctx, index) {
                      var current = story[index];

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                        child: GestureDetector(
                          onTap: () => navigateToStoryDetails(context, current),
                          child: Stack(
                            children: [
                              Container(
                                color: Colors.grey.withOpacity(0.2),
                                height: 200,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(
                                            width: 2,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      child: Image.network(
                                        '$uri/static/images${story[index].images[0].image}',
                                        width: 150,
                                        height: 195,
                                        //fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(6),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    200),
                                            child: Text(
                                              story[index].heading,
                                              style: GoogleFonts.ubuntu(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    200),
                                            child: Text(
                                              story[index].subHeading,
                                              style: GoogleFonts.ubuntu(
                                                fontSize: 23,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    200),
                                            child: Text(
                                              story[index].country,
                                              style: GoogleFonts.ubuntu(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    200),
                                            child: Text(
                                              story[index].summary,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 4,
                                              style: GoogleFonts.ubuntu(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 12, 12, 0),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  // right: MediaQuery.of(context).size.width - 700,
                                  // top: 10,
                                  child: InkWell(
                                    child: wishList.contains(story[index].id)
                                        ? const Icon(Icons.favorite,
                                            color: Color(0xfffca5a5))
                                        : const Icon(Icons.favorite_border,
                                            color: Color(0xfffca5a5)),
                                    onTap: () => setState(
                                      () {
                                        //toggleFavorite();
                                        //_storyId = story[index].id;
                                        wishList.contains(story[index].id)
                                            ? LikeUnlikeStory(
                                                    category: categoryProvider
                                                        .category,
                                                    storyId: story[index].id)
                                                .unlikeStory(context)
                                            : LikeUnlikeStory(
                                                    category: categoryProvider
                                                        .category,
                                                    storyId: story[index].id)
                                                .likeStory(context);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final IconData icon;
  final String selected;
  final String name;
  final VoidCallback onPressed;

  const CategoryButton({
    //super.key,
    required this.onPressed,
    required this.icon,
    required this.selected,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<CategoryProvider>(context).category;
    //print(category);
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(
                  color: category == selected
                      ? const Color(0xfffca5a5)
                      : Colors.black,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 25,
                // color: onPressed == selected ? Colors.amber : Colors.black,
                color: category == selected
                    ? const Color(0xfffca5a5)
                    : Colors.black,
              ),
            ),
            //SizedBox(height: 5),
            // Text(
            //   name,
            //   style: TextStyle(
            //     fontSize: 8,
            //     color: ItemListState._category == selected
            //         ? Color(0xfffca5a5)
            //         : Colors.black
            //   ),
            //   // style: GoogleFonts.ubuntu(
            //   //   fontSize: 11,
            //   //   color: ItemListState._category == selected
            //   //       ? Color(0xfffca5a5)
            //   //       : Colors.black,
            //   //   letterSpacing: -1,
            //   // ),
            // ),
          ],
        ),
      ),
    );
  }
}
