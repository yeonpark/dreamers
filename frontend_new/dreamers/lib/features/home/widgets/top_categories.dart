import 'package:dreamers/constants/global_variables.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        itemCount: GlobalVariables.categoryImages.length,
        scrollDirection: Axis.horizontal,
        itemExtent: 100,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            // => navigateToCategoryPage(
            //   context,
            //   GlobalVariables.categoryImages[index]['title']!,
            // ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Icon(
                      GlobalVariables.categoryIcons[index],
                    ),
                    // Image.asset(
                    //   GlobalVariables.categoryIcons[index]!,
                    //   fit: BoxFit.cover,
                    //   height: 40,
                    //   width: 40,
                    // ),
                  ),
                ),
                Text(
                  GlobalVariables.categoryImages[index]['title']!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
