import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  final int index;

  const MyWidget({
    super.key,
    required this.index,
  });
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (index == 0) ...[
        SizedBox(
          height: 190,
          child: ListView(
            children: const [
              Placeholder(
                color: Colors.red,
              ),
              Placeholder(
                color: Colors.red,
              ),
              Placeholder(
                color: Colors.red,
              ),
            ],
          ),
        ),
      ] else if (index == 1) ...[
        SizedBox(
          height: 190,
          child: ListView(
            children: const [
              Placeholder(
                color: Colors.blue,
              ),
              Placeholder(
                color: Colors.blue,
              ),
              Placeholder(
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ] else ...[
        SizedBox(
          height: 190,
          child: ListView(
            children: const [
              Placeholder(
                color: Colors.green,
              ),
              Placeholder(
                color: Colors.green,
              ),
              Placeholder(
                color: Colors.green,
              ),
            ],
          ),
        ),
      ]
    ]);
  }
}
