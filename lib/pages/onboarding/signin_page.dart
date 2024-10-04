import 'package:flutter/material.dart';
import 'package:geeksynergymovie/auth_state.dart';
import 'package:geeksynergymovie/controller/user_controller.dart';
import 'package:geeksynergymovie/models/user_model.dart';
import 'package:geeksynergymovie/services/validation_service.dart';
import 'package:geeksynergymovie/utils/color.dart';
import 'package:geeksynergymovie/utils/custom_textfield.dart';
import 'package:geeksynergymovie/utils/text_util.dart';
import 'package:provider/provider.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // UserService _userService = UserService();
  bool _passwordValid = true;
  String _passwordErrorText = "Please enter a valid password";
  bool _nameValid = true;
  String _emailErrorText = "Please enter a valid email";
  bool isLoading = false;

  // final FirebaseAuth _auth = FirebaseAuth.instance;

  void _submit(String name, String password) async {
    // Validate name and password
    Map<String, dynamic> validateName = ValidationService.validateName(name);
    Map<String, dynamic> validatePassword =
        ValidationService.validatePassword(password);

    if (validateName['verified']) {
      setState(() {
        _nameValid = true;
      });
    } else {
      setState(() {
        _nameValid = false;
        _emailErrorText = validateName['validatorText'];
      });
    }

    if (validatePassword['verified']) {
      setState(() {
        _passwordValid = true;
      });
    } else {
      setState(() {
        _passwordValid = false;
        _passwordErrorText = validatePassword['validatorText'];
      });
    }

    // Proceed only if the name and password are valid
    if (_nameValid && _passwordValid) {
      setState(() {
        isLoading = true;
      });

      // Access the user controller
      final userController =
          Provider.of<UserController>(context, listen: false);

      // Check if the user exists in the Hive box
      UserModel? existingUser = userController.getUser();

      if (existingUser == null) {
        // No user found in the database, prompt the user to sign up
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.errorColor,
            content: txt(
              "No user found. Please sign up.",
              color: AppColors.primaryTextColor,
            ),
          ),
        );
      } else {
        // Match the user name and password
        if (existingUser.name == name && existingUser.password == password) {
          // Credentials are correct, proceed to sign in
          userController.isLoggedIn = true;
          final authState = Provider.of<AuthState>(context, listen: false);
          authState.login(); // Update the login status in Hive
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.successColor,
              content: txt(
                "Successfully signed in!",
                color: AppColors.primaryTextColor,
              ),
            ),
          );
          Navigator.pushNamed(context, '/homePage'); // Redirect to home page
        } else {
          // Invalid credentials, show error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.errorColor,
              content: txt(
                "Invalid credentials. Please try again.",
                color: AppColors.primaryTextColor,
              ),
            ),
          );
        }
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double sH = MediaQuery.of(context).size.height;
    double sW = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: sW * 0.04,
          vertical: sH * 0.05,
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(
                    height: sH * 0.2,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomTextField(
                        title: "Name",
                        hintText: "Name",
                        controller: nameController,
                        maxLines: 1,
                        validate: _nameValid,
                        validatorText: _emailErrorText,
                      ),
                      SizedBox(
                        height: sH * 0.02,
                      ),
                      CustomTextField(
                        title: "Password",
                        hintText: "Password",
                        controller: passwordController,
                        maxLines: 1,
                        validate: _passwordValid,
                        validatorText: _passwordErrorText,
                        obsureText: true,
                        hideText: true,
                      ),
                      SizedBox(
                        height: sH * 0.04,
                      ),
                      InkWell(
                        onTap: () {
                          _submit(nameController.text, passwordController.text);
                        },
                        child: Container(
                          height: sH * 0.064,
                          width: sW,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            color: AppColors.primaryButtonColor,
                          ),
                          child: Center(
                            child: isLoading
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : txt(
                                    "Sign In",
                                    size: sH * 0.021,
                                    color: AppColors.primaryTextColor,
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: sH * 0.01,
                      ),
                      InkWell(
                        // onTap: _forgotPassword, // Forgot password functionality
                        child: txt(
                          textAlign: TextAlign.right,
                          "Forgot Password?",
                          size: sH * 0.02,
                          color: AppColors.secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: sH * 0.15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: sH * 0.02,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/signUpPage");
                        },
                        child: Container(
                          height: sH * 0.064,
                          width: sW * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            color: AppColors.primaryButtonColor,
                          ),
                          child: Center(
                            child: txt(
                              "Register",
                              size: sH * 0.021,
                              color: AppColors.primaryTextColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
