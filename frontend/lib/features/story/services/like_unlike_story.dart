import 'dart:convert';

import 'package:dreamers/constants/error_handling.dart';
import 'package:dreamers/constants/global_variables.dart';
import 'package:dreamers/constants/utils.dart';
import 'package:dreamers/features/home/services/story_load.dart';
import 'package:dreamers/models/story.dart';
import 'package:dreamers/providers/story_provider.dart';
import 'package:dreamers/providers/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LikeUnlikeStory {
  final String storyId;
  final String category;
  //final LoadStory loadstory = const LoadStory(category: 'wishlist');

  const LikeUnlikeStory({
    //super.key,
    Key? key,
    //required this.parentAction,
    required this.storyId,
    required this.category,
  });

  void likeStory(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('bearer-token');

      if (token == null) {
        prefs.setString('bearer-token', '');
      }

      http.Response res = await http.post(
        Uri.parse('$uri/api/story/like/$storyId/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      // final parsed = jsonDecode(res.body).cast<Map<String, dynamic>>();
      // List<Story> parseStories =
      // parsed.map<Story>((json) => Story.fromJson(json['story']))
      //     .toList();

      //print('test');
      //List<dynamic> jsonList = jsonDecode(res.body) as List<dynamic>;
      //print(jsonList);
      // List<Story> itemList =
      // jsonList.map((json) => Story.fromJson(json)).toList();

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          LoadStory(category: category).loadLikedStory(context);
          //LoadStory(category: category).loadAllStory(context);
          //LoadStory(category: category).loadMyStory(context);

        },
      );
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  // Load Sotries from server
  void unlikeStory(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('bearer-token');

      if (token == null) {
        prefs.setString('bearer-token', '');
      }

      http.Response res = await http.put(
        Uri.parse('$uri/api/story/unlike/$storyId/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          LoadStory(category: category).loadLikedStory(context);
          //LoadStory(category: category).loadAllStory(context);

        },
      );
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
