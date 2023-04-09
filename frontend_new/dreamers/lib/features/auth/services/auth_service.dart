import 'dart:convert';

import 'package:dreamers/common/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:dreamers/constants/error_handling.dart';
import 'package:dreamers/constants/utils.dart';
import "package:dreamers/models/user.dart";
import 'package:dreamers/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:dreamers/constants/global_variables.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: 0,
        isAdmin: false,
        name: name,
        password: password,
        email: email,
        username: email,
        token: '',
      );
      http.Response res = await http.post(
        Uri.parse('$uri/api/user/register/'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      //if (!context.mounted) return;
      //print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/user/login/'),
        body: jsonEncode({
          'username': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      //if (!context.mounted) return;

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          // Navigator.pushReplacement<void, void>(
          //   // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => UserPage(userData: res.body),
          //   ),
          // );
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomBar.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      http.Response userRes = await http.get(
        Uri.parse('$uri/api/user/getuser'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          //'Authorization': 'Bearer ${token}',
          'Authorization': 'Bearer $token',
          //'x-auth-token': token!
        },
      );

      //var response = jsonDecode(userRes.body);
      //print(response);

      var userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setUser(userRes.body);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
