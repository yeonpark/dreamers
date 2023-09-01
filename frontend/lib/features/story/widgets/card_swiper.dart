import 'package:card_swiper/card_swiper.dart';
import 'package:dreamers/models/story.dart';
import 'package:flutter/material.dart';
import 'package:dreamers/constants/constants.dart';

class CardSwiper extends StatelessWidget {
  final List<ImageModel> images;
  const CardSwiper({
    //super.key,
    required this.images,
  });

  // List<String> images = widget.successInfo.images;
  @override
  Widget build(BuildContext context) {
    return Swiper(
      indicatorLayout: PageIndicatorLayout.NONE,
      pagination: SwiperPagination(
        builder: DotSwiperPaginationBuilder(
            color: Pallete.dotColor,
            activeColor: Pallete.contentTextColor,
            activeSize: 12,
            space: 4),
      ),
      itemBuilder: (context, index) {
        return Image.network(
          '$uri/static/images${images[index].image}',
          fit: BoxFit.fill,
        );
      },
      itemCount: images.length,
    );
  }
}

