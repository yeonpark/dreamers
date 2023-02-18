import 'package:flutter/material.dart';

class DonateButton extends StatefulWidget {
  const DonateButton({super.key});

  @override
  State<DonateButton> createState() => _DonateButtonState();
}

class _DonateButtonState extends State<DonateButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
                fixedSize: const MaterialStatePropertyAll(
                  Size.fromWidth(340),
                ),
                textStyle: const MaterialStatePropertyAll(TextStyle(
                  fontSize: 20,
                )),
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 210, 155, 173),
                )),
            child: const Text(
              'Donate Now',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
