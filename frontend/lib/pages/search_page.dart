import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchKey = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    _searchKey.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _searchKey.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    print('current text: ${_searchKey.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // The search area here
          backgroundColor: Colors.white,
          foregroundColor: Colors.black54,
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                controller: _searchKey,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search, color: Colors.black),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear, color: Colors.black),
                      onPressed: () {
                        /* Clear the search field */
                      },
                    ),
                    hintText: 'Find your dreamer...',
                    border: InputBorder.none),
              ),
            ),
          )),
    );
  }
}
