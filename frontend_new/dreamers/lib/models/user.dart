import 'dart:convert';

class User {
  final int id;
  final bool isAdmin;
  final String username;
  final String email;
  final String name;
  final String password;
  final String token;

  User({
    required this.id,
    required this.isAdmin,
    required this.username,
    required this.email,
    required this.name,
    required this.token,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'is_admin': isAdmin,
      'name': name,
      'email': email,
      'username': username,
      'token': token,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      isAdmin: map['is_admin'] ?? '',
      username: map['username'] ?? '',
      token: map['token'] ?? '',
      password: map['password'] ?? '',
    );
  }
  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}

// node js
// class User {
//   final String id;
//   final String name;
//   final String email;
//   final String password;
//   final String address;
//   final String type;
//   final String token;

//   User({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.password,
//     required this.address,
//     required this.type,
//     required this.token,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'email': email,
//       'password': password,
//       'address': address,
//       'type': type,
//       'token': token,
//     };
//   }

//   factory User.fromMap(Map<String, dynamic> map) {
//     return User(
//       id: map['_id'] ?? '',
//       name: map['name'] ?? '',
//       email: map['email'] ?? '',
//       password: map['password'] ?? '',
//       address: map['address'] ?? '',
//       type: map['type'] ?? '',
//       token: map['token'] ?? '',
//     );
//   }
//   String toJson() => json.encode(toMap());

//   factory User.fromJson(String source) => User.fromMap(json.decode(source));
// }
