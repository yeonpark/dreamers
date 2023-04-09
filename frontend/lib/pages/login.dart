import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  _MyAppState createState() => _MyAppState();
}

class AuthService {
  final loginUrl = Uri.parse("http://127.0.0.1:8000/api/user/login/");

  Future<String> login(String username, String password) async {
    var response = await http.post(loginUrl, body: {
      "username": username,
      "password": password,
    });
    return response.body;
  }
}

class _MyAppState extends State<Login> {
  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  String userName = '';
  String passWord = '';
  String returnedValue = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Flutter - LoginPage Demo'),
          ),
          body: Center(
              child: Column(children: <Widget>[
            Container(
                margin: EdgeInsets.all(20),
                child: TextField(
                  controller: idController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'ID',
                  ),
                  onChanged: (id) {
                    setState(() {
                      userName = id;
                      //you can access nameController in its scope to get
                      // the value of text entered as shown below
                      //fullName = nameController.text;
                    });
                  },
                )),
            Container(
                margin: EdgeInsets.all(20),
                child: TextField(
                  controller: pwController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'PW',
                  ),
                  onChanged: (pw) {
                    setState(
                      () {
                        passWord = pw;
                        //you can access nameController in its scope to get
                        // the value of text entered as shown below
                        //passWord = nameController.text;
                      },
                    );
                  },
                )),
            Container(
              margin: EdgeInsets.all(20),
              child: Text(userName),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Text(passWord),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () async {
                AuthService authSerivice = AuthService();
                var responseBody = await authSerivice.login(userName, passWord);
                print(responseBody);
              },
              child: const Text('Login'),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Text(""),
            )
          ]))),
    );
  }
}
