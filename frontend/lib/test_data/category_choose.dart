import 'package:flutter/material.dart';
import '../test_data/success_info.dart';

void main() {
  runApp(const Category());
}

class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: CategorySelect(),
    );
  }
}

class CategorySelect extends StatefulWidget {
  const CategorySelect({Key? key}) : super(key: key);

  @override
  State<CategorySelect> createState() => CategorySelectPageState();
}

class CategorySelectPageState extends State<CategorySelect> {
  var _category = 'last_minute';
  var wishlist = [];
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    final successInfos = successInfo
        .where(
          (successInfos) =>
              successInfos.category.any((category) => category == _category),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gastronomia'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CategoryButton(
                  icon: Icons.abc,
                  onPressed: () => setState(() => _category = 'last_minute'),
                  selected: 'last_minute',
                ),
                CategoryButton(
                  icon: Icons.outlined_flag,
                  onPressed: () => setState(() => _category = 'primary'),
                  selected: 'primary',
                ),
                CategoryButton(
                  icon: Icons.outlined_flag,
                  onPressed: () => setState(() => _category = 'teritary'),
                  selected: 'teritary',
                ),
                CategoryButton(
                  icon: Icons.outlined_flag,
                  onPressed: () => setState(() => print('wishlist clicked')),
                  selected: 'wishlist',
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: successInfos.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
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
                              width: 195, height: 195), //where image should be
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
                                  constraints: BoxConstraints(maxWidth: 180),
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
                                  constraints: BoxConstraints(maxWidth: 180),
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
                                  constraints: BoxConstraints(maxWidth: 180),
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
                                  constraints: BoxConstraints(maxWidth: 180),
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
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final IconData icon;
  final String selected;
  final VoidCallback onPressed;
  const CategoryButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.selected,
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
          ],
        ),
      ),
    );
  }
}
