import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String name;

  const CustomCard({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 35, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.w900,
                    fontSize: 50),
                textAlign: TextAlign.left,
              ),
              Text(
                "HKU",
                style: TextStyle(
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.w400,
                    fontSize: 28),
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Know More",
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                    textAlign: TextAlign.left,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.grey.shade600,
                      size: 20,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
