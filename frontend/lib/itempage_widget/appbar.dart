import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget with PreferredSizeWidget {
  const CommonAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,

      // Maybe can be used as button to go back to the home page?
      leading: IconButton(
        icon: Image.asset('assets/images/logo.png'),
        onPressed: () {},
      ),

      // Location of the search bar
      title: const Center(
        child: Text(
          "Search bar",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),

      // Need the name of the icon used in the ui mock up
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.person_2_outlined,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
