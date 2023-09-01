import 'package:dreamers/constants/constants.dart';
import 'package:dreamers/features/story/services/donate.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PercentBar extends StatefulWidget {
  final double goalPercentage;
  const PercentBar({
    //super.key,
    Key? key,
    required this.goalPercentage,
  }) : super(key: key);

  @override
  State<PercentBar> createState() => _PercentBarState();
}

class _PercentBarState extends State<PercentBar> {
  // double goalPercentage = 1;
  // @override
  // void initState() {
  //   super.initState();
  // }
  // final donatePayPal = Donate();
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15),
          child: Material(
            child: InkWell(
              onTap: () {
                // donatePayPal.donatePaypal(context: context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Donate(),
                    ));
              },
              highlightColor: Pallete.navigationColor,
              overlayColor: MaterialStateProperty.all(
                Pallete.navigationColor,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(45),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                height: 40,
                child: LinearPercentIndicator(
                  padding: EdgeInsets.all(0),
                  backgroundColor: Colors.white,
                  //fillColor: primaryColor,
                  // Subtract 30 here because of padding of 15 on both left and right
                  // Additional 57 for the goal Text and 5 pixel sized box
                  // There are two ways, get the length of text and minus it or remove the text
                  width: MediaQuery.of(context).size.width - 32,
                  lineHeight: 35.0,
                  percent: widget.goalPercentage / 100,
                  //percent: ((widget.goalPercentage != null) ? widget.goalPercentage : 0)/ 100,
                  // Have to discuss how to represent, with digit on or off
                  center: Text(
                    "Donate Now",
                    style: GoogleFonts.ubuntu(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  //barRadius: const Radius.circular(45),
                  // Need change to color to theme color
                  progressColor: Pallete.primaryColor,
                ),
              ),
            ),
          ),
        ),
        //const SizedBox(width: 5),
      ],
    );
  }
}
