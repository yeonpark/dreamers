import 'package:dreamers/pages/itempage.dart';
import 'package:dreamers/presentation/flamingo_icons.dart';
import 'package:flutter/material.dart';
import '../test_data/success_info.dart';
import '../pages/search_page.dart';
import 'package:google_fonts/google_fonts.dart';
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
  State<ItemList> createState() => ItemListState();
}

class ItemListState extends State<ItemList> {
  // This widget is the main page of the application.
  static var _category = 'last_minute';

  // _updateCategory(SuccessInfo current) {
  //   setState(() {
  //     //toggleFavorite();
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

  // GlobalKey<ItemPageState> _keyItemPage = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final successInfos = successInfo
        .where(
          (successInfos) =>
              successInfos.category.any((category) => category == _category),
        )
        .toList();

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
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const SearchPage(),
                            ),
                          ),
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
                                children: [
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
                                    style: GoogleFonts.lato(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
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
                            CategoryButton(
                              icon: Icons.timer_sharp,
                              name: 'Last Minute',
                              onPressed: () =>
                                  setState(() => _category = 'last_minute'),
                              selected: 'last_minute',
                            ),
                            CategoryButton(
                              icon: Icons.child_care,
                              name: 'Primary/Secondary',
                              onPressed: () =>
                                  setState(() => _category = 'primary'),
                              selected: 'primary',
                            ),
                            CategoryButton(
                              icon: Icons.school_outlined,
                              name: 'Teritary',
                              onPressed: () =>
                                  setState(() => _category = 'teritary'),
                              selected: 'teritary',
                            ),
                            CategoryButton(
                              icon: Icons.shopping_cart_outlined,
                              name: 'Wish List',
                              onPressed: () =>
                                  setState(() => _category = 'wishlist'),
                              selected: 'wishlist',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Flexible(
                flex: 5,
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                    itemCount: successInfos.length,
                    itemBuilder: (ctx, index) {
                      var current = successInfos[index];
                      var favorites = [];

                      void toggleFavorite() {
                        if (current.category.contains('wishlist')) {
                          current.category.remove('wishlist');
                          favorites.remove(current);
                        } else {
                          current.category.add('wishlist');
                          favorites.add(current);
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ItemPage(
                                  successInfo: current, //successInfos[index],
                                  parentAction: toggleFavorite,
                                ),
                              ),
                            ).then((value) {
                              setState(() {});
                            });
                          },
                          child: Stack(
                            children: [
                              Container(
                                color: Colors.grey.withOpacity(0.2),
                                height: 200,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          right: BorderSide(
                                            width: 2,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      child: Image.asset(
                                          successInfos[index].iconImage,
                                          width: 150,
                                          height: 195), //where image should be
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(6),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    200),
                                            child: Text(
                                              successInfos[index].fieldOfStudy,
                                              style: GoogleFonts.lato(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    200),
                                            child: Text(
                                              successInfos[index].name,
                                              style: GoogleFonts.lato(
                                                fontSize: 23,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    200),
                                            child: Text(
                                              successInfos[index].nationality,
                                              style: GoogleFonts.lato(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    200),
                                            child: Text(
                                              successInfos[index].description,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 4,
                                              style: GoogleFonts.lato(
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
                                    child: successInfos[index]
                                            .category
                                            .contains('wishlist')
                                        ? Icon(Icons.favorite,
                                            color: Color(0xfffca5a5))
                                        : Icon(Icons.favorite_border,
                                            color: Color(0xfffca5a5)),
                                    onTap: () => setState(
                                      () {
                                        toggleFavorite();
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
    super.key,
    required this.onPressed,
    required this.icon,
    required this.selected,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ItemListState._category == selected
                        ? Color(0xfffca5a5)
                        : Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 25,
                  // color: onPressed == selected ? Colors.amber : Colors.black,
                  color: ItemListState._category == selected
                      ? Color(0xfffca5a5)
                      : Colors.black,
                )),
            SizedBox(height: 3),
            Text(
              name,
              style: GoogleFonts.lato(
                fontSize: 11,
                color: ItemListState._category == selected
                    ? Color(0xfffca5a5)
                    : Colors.black,
                letterSpacing: -1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
