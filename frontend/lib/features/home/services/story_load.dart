import 'dart:convert';

import 'package:dreamers/constants/error_handling.dart';
import 'package:dreamers/constants/global_variables.dart';
import 'package:dreamers/constants/utils.dart';
import 'package:dreamers/models/story.dart';
import 'package:dreamers/providers/category_provider.dart';
import 'package:dreamers/providers/story_provider.dart';
import 'package:dreamers/providers/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadStory {
  final String category;

  const LoadStory({
    Key? key,
    required this.category,
  });


  void loadLikedStory(
    BuildContext context,

  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('bearer-token');

      if (token == null) {
        prefs.setString('bearer-token', '');
      }

      http.Response res = await http.get(
        Uri.parse('$uri/api/user/get-liked-stories/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      final parsed = jsonDecode(res.body).cast<Map<String, dynamic>>();
      List<Story> parseStories =
          parsed.map<Story>((json) => Story.fromJson(json['story'])).toList();

      List<String> extractId(List<Story> parseStories) {
        return parseStories.map((story) => story.id).toList();
      }

      List<String> wishlist = extractId(parseStories);

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            // If the category is 'wishlist', set the jsonList of the WishListProvider and MyProvider
            Provider.of<WishListProvider>(context, listen: false)
                .setjsonList(wishlist);
          }
      );

    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  // Load Sotries from server
  void loadAllStory(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('bearer-token');

      if (token == null) {
        prefs.setString('bearer-token', '');
      }

      http.Response res = await http.get(
        Uri.parse('$uri/api/story/all/?category=$category'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      List<dynamic> jsonList = jsonDecode(res.body); // as List<dynamic>;

      List<Story> itemList =
          jsonList.map((json) => Story.fromJson(json)).toList();


      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          Provider.of<StoryProvider>(context, listen: false).setjsonList(itemList);
        },
      );
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void loadWishStory(
      BuildContext context,
      ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('bearer-token');

      if (token == null) {
        prefs.setString('bearer-token', '');
      }

      http.Response res = await http.get(
        Uri.parse('$uri/api/user/get-liked-stories/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      final parsed = jsonDecode(res.body).cast<Map<String, dynamic>>();
      List<Story> parseStories =
      parsed.map<Story>((json) => Story.fromJson(json['story'])).toList();

      List<String> extractId(List<Story> parseStories) {
        return parseStories.map((story) => story.id).toList();
      }

      List<String> wishlist = extractId(parseStories);

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            // If the category is 'wishlist', set the jsonList of the WishListProvider and MyProvider
            Provider.of<WishListProvider>(context, listen: false)
                .setjsonList(wishlist);
            Provider.of<StoryProvider>(context, listen: false)
                .setjsonList(parseStories);
          }
      );
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
