import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import '../test_data/success_info.dart';

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
