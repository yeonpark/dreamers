// import 'package:dreamers/constants/global_variables.dart';
// // import 'package:dreamers/features/account/widgets/below_app_bar.dart';
// // import 'package:dreamers/features/account/widgets/orders.dart';
// // import 'package:dreamers/features/account/widgets/top_buttons.dart';
// import 'package:flutter/material.dart';

// class FeedScreen extends StatelessWidget {
//   const FeedScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(50),
//         child: AppBar(
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(
//               gradient: GlobalVariables.appBarGradient,
//             ),
//           ),
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 alignment: Alignment.topLeft,
//                 // child: Image.asset(
//                 //   'assets/images/amazon_in.png',
//                 //   width: 120,
//                 //   height: 45,
//                 //   color: Colors.black,
//                 // ),
//               ),
//               Container(
//                 padding: const EdgeInsets.only(left: 15, right: 15),
//                 child: Row(
//                   children: const [
//                     Padding(
//                       padding: EdgeInsets.only(right: 15),
//                       child: Icon(Icons.notifications_outlined),
//                     ),
//                     Icon(
//                       Icons.search,
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//       // body: Column(
//       //   children: const [
//       //     BelowAppBar(),
//       //     SizedBox(height: 10),
//       //     TopButtons(),
//       //     SizedBox(height: 20),
//       //     Orders(),
//       //   ],
//       // ),
//     );
//   }
// }
import 'package:dreamers/features/feeds/screens/success_info.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dreamers/features/feeds/screens/custom_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedScreen> {
  // we must define initState and dispose for our class variables we've defined.
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const CardSwiper();
  }
}

class CardSwiper extends StatelessWidget {
  const CardSwiper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.grey.shade200, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.1, 0.9]),
          ),
          child: SafeArea(
            child: Column(children: <Widget>[
              Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(26.0, 26.0, 26.0, 0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Explore",
                            style: TextStyle(
                              color: Colors.grey.shade900,
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Our Success Stories",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          )
                        ]),
                  )),
              Flexible(
                flex: 7,
                child: Swiper(
                  itemCount: 4,
                  itemWidth: MediaQuery.of(context).size.width,
                  itemHeight: MediaQuery.of(context).size.height,
                  layout: SwiperLayout.TINDER,
                  pagination: SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                          color: Colors.grey.shade300,
                          activeColor: Colors.grey.shade600,
                          activeSize: 12,
                          space: 4)),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              CustomCard(
                                name: successInfo[index].name,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 400,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Hero(
                                  tag: successInfo[index].position,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(32),
                                      child: Image.asset(
                                          successInfo[index].iconImage,
                                          fit: BoxFit.cover))),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ]),
          )),
      //bottomNavigationBar: const CustomBottomNavbar(),
    );
  }
}
