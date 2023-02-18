import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PercentBar extends StatefulWidget {
  PercentBar({
    super.key,
    required this.goalPercentage,
  });

  final double goalPercentage;

  @override
  State<PercentBar> createState() => _PercentBarState();
}

class _PercentBarState extends State<PercentBar> {
  // final GlobalKey _key = GlobalKey();
  // final Size _size = Size.zero;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        //mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            'Goal (%)',
            // Or fix the size of text?
            // key: _key,
          ),
          const SizedBox(width: 5),
          LinearPercentIndicator(
            // Subtract 30 here because of padding of 15 on both left and right
            // Additional 57 for the goal Text and 5 pixel sized box
            // There are two ways, get the length of text and minus it or remove the text
            width: MediaQuery.of(context).size.width -
                87, //-_key.currentContext.size.width,
            lineHeight: 20.0,
            percent: widget.goalPercentage / 100,
            // Have to discuss how to represent, with digit on or off
            center: Text("${widget.goalPercentage}%"),
            barRadius: const Radius.circular(45),
            // Need change to color to theme color
            progressColor: const Color.fromARGB(255, 210, 155, 173),
          ),
          //const SizedBox(width: 5),
        ],
      ),
    );
  }
}
