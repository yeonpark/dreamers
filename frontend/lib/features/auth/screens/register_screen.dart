import 'package:dreamers/common/widgets/common.dart';
import 'package:dreamers/constants/constants.dart';
import 'package:dreamers/features/auth/screens/login_screen.dart';
import 'package:dreamers/features/auth/services/auth_service.dart';
import 'package:dreamers/features/auth/widgets/auth_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register-screen';
  // static route() => MaterialPageRoute(
  //   builder: (context) => const RegisterScreen(),
  // );
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final appbar = UIConstants.appBar();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  final _signUpFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: appbar,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _signUpFormKey,
              child: Column(
                children: [
                  AuthField(controller: _usernameController, hintText: 'Username'),
                  const SizedBox(height: 25),
                  AuthField(controller: _emailController, hintText: 'Email Address'),
                  const SizedBox(height: 25),
                  AuthField(controller: _passwordController, hintText: 'Password'),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.topRight,
                    child: RoundedSmallButton(
                      onTap: () {
                        if (_signUpFormKey.currentState!.validate()) {
                          signUpUser();
                        }
                      },
                      label: 'Register',
                      textColor: Pallete.contentTextColor,
                    ),
                  ),
                  const SizedBox(height: 40),
                  RichText(
                    text: TextSpan(
                      text: "Already have an account?",
                      style: const TextStyle(
                        color: Pallete.neutralColor,
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: ' Login',
                          style: const TextStyle(
                            color: Pallete.primaryColor,
                            fontSize: 16,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
                              // Navigator.push(
                              //   context,
                              //   SignUpView.route(),
                              // );
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}