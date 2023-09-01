import 'package:dreamers/common/widgets/common.dart';
import 'package:dreamers/constants/constants.dart';
import 'package:dreamers/features/auth/screens/register_screen.dart';
import 'package:dreamers/features/auth/services/auth_service.dart';
import 'package:dreamers/features/auth/widgets/auth_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login-screen';
  // static route() => MaterialPageRoute(
  //   builder: (context) => const LoginScreen(),
  // );
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final appbar = UIConstants.appBar();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    //_emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  void signInUser() {
    authService.signInUser(
      context: context,
      username: _usernameController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    //final isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: appbar,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _signInFormKey,
              child: Column(
                children: [
                  AuthField(controller: _usernameController, hintText: 'Username'),
                  const SizedBox(height: 25),
                  AuthField(controller: _passwordController, hintText: 'Password'),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.topRight,
                    child: RoundedSmallButton(
                      onTap: () {
                        if (_signInFormKey.currentState!.validate()) {
                          signInUser();
                        }
                      },
                      label: 'Login',
                      textColor: Pallete.contentTextColor,
                    ),
                  ),
                const SizedBox(height: 40),
                RichText(
                  text: TextSpan(
                    text: "Don't have an account?",
                    style: const TextStyle(
                      color: Pallete.neutralColor,
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: ' Register',
                        style: const TextStyle(
                          color: Pallete.primaryColor,
                          fontSize: 16,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamedAndRemoveUntil(context, RegisterScreen.routeName, (route) => false);
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