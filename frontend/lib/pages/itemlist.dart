import 'package:flutter/material.dart';
import '../test_data/success_info.dart';
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
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  // This widget is the main page of the application.
  var _category = 'last_minute';

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
                      onPressed: () => setState(() => _category = 'primary'),
                      selected: 'primary',
                    ),
                    CategoryButton(
                      icon: Icons.school_outlined,
                      name: 'Teritary',
                      onPressed: () => setState(() => _category = 'teritary'),
                      selected: 'teritary',
                    ),
                    CategoryButton(
                      icon: Icons.female_outlined,
                      name: 'Female',
                      onPressed: () =>
                          setState(() => print('wishlist clicked')),
                      selected: 'wishlist',
                    ),
                  ],
                ),
              ),
            ),
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Expanded(
                child: ListView.builder(
                  itemCount: successInfos.length,
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                      child: Container(
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
                              child: Image.asset(successInfos[index].iconImage,
                                  width: 195,
                                  height: 195), //where image should be
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ConstrainedBox(
                                      constraints:
                                          BoxConstraints(maxWidth: 180),
                                      child: Text(
                                        successInfos[index].fieldOfStudy,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    ConstrainedBox(
                                      constraints:
                                          BoxConstraints(maxWidth: 180),
                                      child: Text(successInfos[index].name,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                          )),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    ConstrainedBox(
                                      constraints:
                                          BoxConstraints(maxWidth: 180),
                                      child: Text(
                                        successInfos[index].nationality,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    ConstrainedBox(
                                      constraints:
                                          BoxConstraints(maxWidth: 180),
                                      child: Text(
                                        successInfos[index].description,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
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
      child: Container(
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 25,
                  color: onPressed == selected ? Colors.amber : Colors.black,
                )),
            SizedBox(height: 3),
            Text(
              name,
              style: TextStyle(
                  letterSpacing: -1, fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
