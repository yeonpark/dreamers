import 'package:flutter/material.dart';
import 'components/custon_bottom_navbar.dart';
import 'components/header_widget.dart';
import 'pages/details.dart';
import 'package:card_swiper/card_swiper.dart';
import 'components/custom_card.dart';
import 'constants/colors.dart';
import 'test_data/success_info.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
      backgroundColor: gradientEndColor,
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [gradientStartColor, gradientEndColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.1, 0.9])),
          child: SafeArea(
            child: Column(children: <Widget>[
              const HeaderWidget(),
              SizedBox(
                height: 600,
                child: Swiper(
                  itemCount: successInfo.length,
                  itemWidth: MediaQuery.of(context).size.width,
                  itemHeight: MediaQuery.of(context).size.height,
                  layout: SwiperLayout.TINDER,
                  pagination: SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                          color: dotColor,
                          activeColor: contentTextColor,
                          activeSize: 12,
                          space: 4)),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation,
                                    secondaryAnimation) =>
                                DetailsPage(successInfo: successInfo[index]),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.ease;
                              final tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));
                              final offsetAnimation = animation.drive(tween);
                              return SlideTransition(
                                  position: offsetAnimation, child: child);
                            },
                          ),
                        );
                      },
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
    );
  }
}
