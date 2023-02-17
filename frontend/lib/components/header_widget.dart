import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(26.0, 26.0, 26.0, 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Explore",
          style: GoogleFonts.ubuntu(
            color: titleTextColor,
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
              style: GoogleFonts.ubuntu(
                color: contentTextColor,
                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        )
      ]),
    );
  }
}
