import 'dart:convert';
import 'dart:io';

import 'package:dreamers/constants/error_handling.dart';
import 'package:dreamers/constants/global_variables.dart';
import 'package:dreamers/providers/story_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:dreamers/models/story.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

class ProfileServices {
  void loadUserProfile({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('bearer-token');

      if (token == null) {
        prefs.setString('bearer-token', '');
      }

      http.Response res = await http.post(
        Uri.parse('$uri/api/user/profile/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      dynamic jsonResponse = jsonDecode(res.body);

      UserModel userProfile = UserModel.fromJson(jsonResponse);
      print(userProfile.profileImage);
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            Provider.of<StoryProvider>(context, listen: false)
                .setUserjsonList([userProfile]);
          });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void updateProfile({
    required BuildContext context,
    required String updatedIntroduction,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('bearer-token');

      if (token == null) {
        prefs.setString('bearer-token', '');
      }

      http.Response res =
          await http.put(Uri.parse('$uri/api/user/profile/update/'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode({'introduction': updatedIntroduction}));

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            Fluttertoast.showToast(msg: "Profile successfully updated!");
          });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void uploadProfileImage({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('bearer-token');

      if (token == null) {
        prefs.setString('bearer-token', '');
      }

      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      var request = http.MultipartRequest(
          "PUT", Uri.parse('$uri/api/user/upload-profile-image/'));

      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      };

      request.headers.addAll(headers);
      http.MultipartFile multipartFile =
          await http.MultipartFile.fromPath("profile_image", pickedImage!.path);
      request.files.add(multipartFile);
      request.send().then((response) {
        if (response.statusCode == 200) {
          Fluttertoast.showToast(msg: "Profile Image Uploaded!");
        }
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
