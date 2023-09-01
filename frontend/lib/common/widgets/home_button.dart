import 'package:dreamers/common/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:dreamers/features/story/screens/post_payment_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeButton extends StatefulWidget {
  HomeButton({Key? key, this.title, this.onTap}) : super(key: key);

  String? title;
  VoidCallback? onTap;

  @override
  State<HomeButton> createState() => _HomeButtonState();
}

class _HomeButtonState extends State<HomeButton> {
  void navigateToBottomBar() {
    Navigator.pushNamed(context, BottomBar.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: navigateToBottomBar,
      child: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Center(
          child: Text(
            widget.title ?? '',
            style: GoogleFonts.ubuntu(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
