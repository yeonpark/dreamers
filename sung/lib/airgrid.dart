import 'package:flutter/material.dart';

class airGrids extends StatelessWidget {
  final String image;
  final String address;
  final String view;
  final String dates;
  final String price;

  airGrids({
    super.key,
    required this.image,
    required this.address,
    required this.view,
    required this.dates,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  Image.asset(image, width: 400),
                  Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: IconButton(
                            onPressed: () => print('pressed'),
                            icon: Icon(
                              Icons.favorite_border_rounded,
                              color: Colors.white,
                              size: 30,
                            )),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(address, style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(),
                Icon(Icons.star, size: 18),
                Text('5.0'),
              ],
            ),
            Text(
              view,
              style: TextStyle(color: Colors.black.withOpacity(0.5)),
            ),
            Text(
              dates,
              style: TextStyle(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: price,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  WidgetSpan(
                    child: SizedBox(width: 10),
                  ),
                  TextSpan(text: 'night'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
