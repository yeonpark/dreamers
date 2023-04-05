import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key, required this.userData});

  final userData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(userData),
    ));
  }
}
