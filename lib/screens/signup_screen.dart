import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studdy_bestie/resources/auth_methods.dart';
import 'package:studdy_bestie/screens/login_screen.dart';
import 'package:studdy_bestie/utils/colors.dart';
import 'package:studdy_bestie/utils/utils.dart';
import 'package:studdy_bestie/widgets/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _reEnterPasswordController =
      TextEditingController();
  final TextEditingController _nickNameController = TextEditingController();
  bool _isLoadingCircle = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nickNameController.dispose();
  }

  // Call this when sign up button is pressed.
  signUpUser() async {
    setState(() {
      _isLoadingCircle = true;
    });
    String signUpResult = await AuthMethods().signUpUserWithEmail(
      email: _emailController.text,
      password: _passwordController.text,
      reEnterPassword: _reEnterPasswordController.text,
      nickName: _nickNameController.text,
    );
    if (signUpResult != "Signup Successful!") {
      showSnackBar(signUpResult, context);
    }
    setState(() {
      _isLoadingCircle = false;
    });
  }

  void navigateToLogIn() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginInScreen()));
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
                  TextFieldInput(
                      textEditingController: _reEnterPasswordController,
                      hintText: "Re-enter Password",
                      textInputType: TextInputType.visiblePassword),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFieldInput(
                      textEditingController: _nickNameController,
                      hintText: "What's your Name?",
                      textInputType: TextInputType.text),
                  const SizedBox(
                    height: 12,
                  ),
                  InkWell(
                    onTap: signUpUser,
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
                          : const Text('Sign Up!'),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account? '),
                      GestureDetector(
                        onTap: navigateToLogIn,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: const Text(
                            'Login',
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
