import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import '../test_data/success_info.dart';

class DetailsPage extends StatelessWidget {
  final SuccessInfo successInfo;

  const DetailsPage({Key? key, required this.successInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 300,
                        ),
                        Text(
                          successInfo.name,
                          style: GoogleFonts.ubuntu(
                            fontSize: 56,
                            fontWeight: FontWeight.w900,
                            color: titleTextColor,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          'Solar System',
                          style: GoogleFonts.ubuntu(
                            fontSize: 36,
                            fontWeight: FontWeight.w300,
                            color: titleTextColor,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const Divider(
                          color: Colors.black38,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          successInfo.description,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.ubuntu(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: contentTextColor,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Divider(
                          color: Colors.black38,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0, bottom: 10),
                    child: Text(
                      'Gallery',
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          color: contentTextColor,
                          fontFamily: 'Avenir'),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: 250,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: ListView.builder(
                        itemCount: successInfo.images.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32)),
                            child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(
                                  successInfo.images[index],
                                  fit: BoxFit.cover,
                                )),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(right: -64, child: Image.asset(successInfo.iconImage)),
            Positioned(
              left: 32,
              top: 60,
              child: Text(
                successInfo.position.toString(),
                style: TextStyle(
                    fontSize: 247,
                    color: titleTextColor.withOpacity(0.08),
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Avenir'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
            )
          ],
        ),
      ),
    );
  }
}
