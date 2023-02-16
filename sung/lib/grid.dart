import 'package:flutter/material.dart';
import 'package:mock_airbnb/onclickperson.dart';
import 'package:mock_airbnb/basic_info.dart';

class Grids extends StatefulWidget {
  final String image;
  final String field;
  final String name;
  final String nationality;
  final String sentences;

  Grids({
    super.key,
    required this.image,
    required this.field,
    required this.name,
    required this.nationality,
    required this.sentences,
  });

  @override
  State<Grids> createState() => _GridsState();
}

class _GridsState extends State<Grids> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OnClickPerson(),
            ),
          );
        },
        child: Container(
          color: Colors.grey.withOpacity(0.2),
          height: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        width: 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  child: Image.asset(widget.image, width: 195, height: 195)),
              Padding(
                padding: const EdgeInsets.all(6),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 180),
                        child: Text(
                          widget.field,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 180),
                        child: Text(widget.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            )),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 180),
                        child: Text(
                          widget.nationality,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 180),
                        child: Text(
                          widget.sentences,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
