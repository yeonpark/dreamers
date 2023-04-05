import 'package:http/http.dart' as http;

main() async {
  AuthService authSerivice = AuthService();
  var responseBody = await authSerivice.login("sung", "dhuh34");
  print(responseBody);
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
