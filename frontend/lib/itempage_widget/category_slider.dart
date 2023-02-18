// This file not used for now - Yeon

import 'package:flutter/material.dart';

class CategorySlider extends StatefulWidget {
  const CategorySlider({super.key});

  @override
  State<CategorySlider> createState() => _CategorySliderState();
}

class _CategorySliderState extends State<CategorySlider> {
  int selectedIndex = 0;
  // Button names for slider of the Description
  List category = ['Summary', 'Full Story', 'Person Detail'];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        // Flexible(
        //   flex: 3,
        //   child: CategoryListView(index: selectedIndex),
        // ),
      ],
    );
  }
}

// class CategoryListView extends StatelessWidget {
//   final int index;

//   const CategoryListView({
//     super.key,
//     required this.index,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       if (index == 0) ...[
//         const TodoCard(
//           todo: Todo(id: "Hi", description: "test"),
//           cardcolor: Colors.blue,
//           popupcardcolor: Colors.black,
//         ),
//       ] else if (index == 1) ...[
//         const TodoCard(
//           todo: Todo(id: "Hi", description: "test"),
//           cardcolor: Colors.red,
//           popupcardcolor: Colors.green,
//         ),
//         // SizedBox(
//         //   height: 190,
//         //   child: ListView(
//         //     children: const [
//         //       Placeholder(
//         //         color: Colors.blue,
//         //       ),
//         //       Placeholder(
//         //         color: Colors.blue,
//         //       ),
//         //       Placeholder(
//         //         color: Colors.blue,
//         //       ),
//         //     ],
//         //   ),
//         // ),
//       ] else ...[
//         const TodoCard(
//           todo: Todo(id: "Hi", description: "test"),
//           cardcolor: Colors.pink,
//           popupcardcolor: Colors.purple,
//         ),
//       ]
//     ]);
//   }
// }
