import 'dart:convert';

import 'dart:ffi';

class User {
  //final int id;
  //final bool isAdmin;
  final String username;
  final String name;
  final String password;
  final String email;
  final String token;

  User({
    required this.name,
    //required this.id,
    //required this.isAdmin,
    required this.username,
    required this.password,
    required this.email,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      //'id': id,
      //'isAdmin': isAdmin,
      'name': name,
      'username': username,
      'password': password,
      'email': email,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      //id: map['_id'] ?? -1,
      username: map['username'] ?? '',
      //isAdmin: map['is_admin'] ?? false,
      email: map['email'] ?? '',
      token: map['token'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    //int? id,
    //bool? isAdmin,
    String? name,
    String? username,
    String? email,
    String? password,
    String? token,

  }) {
    return User(
      //id: id ?? this.id,
      //isAdmin: isAdmin ?? this.isAdmin,
      username: username ?? this.username,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      token: token ?? this.token,

    );
  }
}