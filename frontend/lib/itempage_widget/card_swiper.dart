import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class CardSwiper extends StatefulWidget {
  const CardSwiper({super.key});

  @override
  State<CardSwiper> createState() => _CardSwiperState();
}

class _CardSwiperState extends State<CardSwiper> {
  List<String> images = [
    "https://images.wallpapersden.com/image/download/purple-sunrise-4k-vaporwave_bGplZmiUmZqaraWkpJRmbmdlrWZlbWU.jpg",
    "https://wallpaperaccess.com/full/2637581.jpg",
    "https://uhdwallpapers.org/uploads/converted/20/01/14/the-mandalorian-5k-1920x1080_477555-mm-90.jpg"
  ];

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
            images[index],
            fit: BoxFit.fill,
          );
        },
        itemCount: 3,
        control: SwiperControl(),
      ),
    );
  }
}
