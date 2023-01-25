import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studdy_bestie/resources/auth_methods.dart';
import 'package:studdy_bestie/screens/landing_screen.dart';
import 'package:studdy_bestie/screens/signup_screen.dart';
import 'package:studdy_bestie/utils/colors.dart';
import 'package:studdy_bestie/utils/utils.dart';
import 'package:studdy_bestie/widgets/text_field_input.dart';

class LoginInScreen extends StatefulWidget {
  const LoginInScreen({super.key});

  @override
  State<LoginInScreen> createState() => _LoginInScreenState();
}

class _LoginInScreenState extends State<LoginInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoadingCircle = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoadingCircle = true;
    });
    String loginStatus = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (loginStatus != "Login Successful!") {
      showSnackBar(loginStatus, context);
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const LandingScreen()));
    }
    setState(() {
      _isLoadingCircle = false;
    });
  }

  void navigateToSignUp() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(),
                  ),
                  TextFieldInput(
                      textEditingController: _emailController,
                      hintText: "Enter Email",
                      textInputType: TextInputType.emailAddress),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFieldInput(
                      textEditingController: _passwordController,
                      hintText: "Enter Password",
                      textInputType: TextInputType.visiblePassword),
                  const SizedBox(
                    height: 12,
                  ),
                  InkWell(
                    onTap: loginUser,
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          color: primaryColorPalette),
                      child: _isLoadingCircle
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const Text('Login'),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('New here? '),
                      GestureDetector(
                        onTap: navigateToSignUp,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: const Text(
                            'Sign Up!',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ))),
    );
  }
}
