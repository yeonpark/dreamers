import 'package:flutter/material.dart';
import 'package:dreamers/constants/error_handling.dart';
import 'package:dreamers/constants/utils.dart';
import "package:dreamers/models/user.dart";
import 'package:http/http.dart' as http;
import 'package:dreamers/constants/global_variables.dart';
import 'package:dreamers/features/auth/screens/userpage.dart';

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
        id: '',
        isAdmin: false,
        name: name,
        password: password,
        email: email,
        username: '',
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
    required String username,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        isAdmin: false,
        name: '',
        password: password,
        email: '',
        username: username,
        token: '',
      );
      http.Response res = await http.post(
        Uri.parse('$uri/api/user/login/'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(res.body);
      //if (!context.mounted) return;

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          // showSnackBar(
          //   context,
          //   'Login Successful!',
          // );
          Navigator.pushReplacement<void, void>(
            // Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserPage(userData: res.body),
            ),
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
