import 'dart:convert';

import 'package:dreamers/common/widgets/bottom_bar.dart';
import 'package:dreamers/constants/error_handling.dart';
import 'package:dreamers/constants/global_variables.dart';
import 'package:dreamers/features/auth/screens/login_screen.dart';
import 'package:dreamers/models/user.dart';
import 'package:dreamers/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  // sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      User user = User(
        username: username,
        name: username,
        password: password,
        email: email,
        token: '',
      );
      http.Response res = await http.post(
        Uri.parse('$uri/api/user/register/'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          Navigator.pushNamed(
            context,
            LoginScreen.routeName,
          );
          Fluttertoast.showToast(
              msg: "Account created! Login with the same credentials!");
        },
      );
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  // sign in user
  void signInUser({
    required BuildContext context,
    required String username,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/user/login/'),
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('bearer-token', jsonDecode(res.body)['token']);
          Navigator.pushNamed(
            context,
            BottomBar.routeName,
          );
        },
      );
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void logout({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('bearer-token');

      if (token != null) {
        await prefs.setString('bearer-token', '');
        Navigator.pushNamedAndRemoveUntil(
            context, LoginScreen.routeName, (route) => false);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
