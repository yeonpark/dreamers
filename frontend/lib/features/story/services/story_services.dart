import 'dart:io';
import 'package:dreamers/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StoryServices {
  void postStory({
    required BuildContext context,
    required String heading,
    required String sub_heading,
    required String summary,
    required String full_detail,
    required String country,
    required String category,
    required int fundRequesSize,
    required List<File> images,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('bearer-token');

      if (token == null) {
        prefs.setString('bearer-token', '');
      }

      var request = http.MultipartRequest(
          "POST", Uri.parse('$uri/api/story/post-story/'));

      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      };
      request.headers.addAll(headers);

      for (var i = 0; i < images.length; i++) {
        http.MultipartFile multipartFile =
            await http.MultipartFile.fromPath("images", images[i].path);
        request.files.add(multipartFile);
      }

      request.fields['heading'] = heading;
      request.fields['sub_heading'] = sub_heading;
      request.fields['country'] = country;
      request.fields['summary'] = summary;
      request.fields['full_detail'] = full_detail;
      request.fields['category'] = category;
      request.fields['fund_request_size'] = fundRequesSize.toString();

      request.send().then((response) {
        if (response.statusCode == 200) {
          Fluttertoast.showToast(msg: "Story Successfully Added!");
        }
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
