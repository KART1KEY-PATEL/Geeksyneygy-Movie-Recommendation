import 'package:flutter/material.dart';
import 'package:geeksynergymovie/auth_state.dart';
import 'package:geeksynergymovie/controller/user_controller.dart';
import 'package:geeksynergymovie/models/user_model.dart';
import 'package:geeksynergymovie/services/validation_service.dart';
import 'package:geeksynergymovie/utils/color.dart';
import 'package:geeksynergymovie/utils/custom_drop_drown.dart';
import 'package:geeksynergymovie/utils/custom_textfield.dart';
import 'package:geeksynergymovie/utils/text_util.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool nameValid = true;
  String _nameErrorText = "Please enter your name";
  bool phoneNumberValid = true;
  String _phoneNumberErrorText = "Please enter your phone number";
  bool _passwordValid = true;
  String _passwordErrorText = "Please enter a valid password";
  bool _confirmPasswordValid = true;
  String _confirmPasswordErrorText = "Password does not match";
  bool _emailValid = true;
  String _emailErrorText = "Please enter a valid email";
  bool isLoading = false;

  bool _isCheckboxChecked = false; // Track checkbox state

  // Function to open the link
  String? selectProfession;

  // Dropdown for Code Validity
  Widget _buildDropdownFieldCodeValidity(String label, double sH, double sW) {
    List<String> professionOptions = [
      'Intern',
      'App Developer',
      'Web Developer',
      'UI/UX Designer',
      'Data Scientist',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        txt(label, size: sH * 0.018, weight: FontWeight.w500),
        SizedBox(height: sH * 0.01),
        SizedBox(
          width: sW,
          height: sH * 0.065,
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return CustomDropdownButton2(
                hint: '--Select Profession--',
                value: selectProfession,
                dropdownItems: professionOptions,
                dropdownWidth: sW * 0.92,
                onChanged: (value) {
                  setModalState(() {
                    selectProfession = value;
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> _submit(String name, String phoneNumber, String email,
      String password, String confirmPassword) async {
    if (!_isCheckboxChecked) {
      // Show error message if checkbox is not checked
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.errorColor,
          content: txt(
            "Please agree to the Terms and Conditions",
            color: AppColors.primaryTextColor,
          ),
        ),
      );
      return;
    }
    Map<String, dynamic> validateName = ValidationService.validateName(name);
    Map<String, dynamic> validatePhoneNumber =
        ValidationService.validatePhoneNumber(phoneNumber);
    Map<String, dynamic> validateEmail = ValidationService.validateEmail(email);
    Map<String, dynamic> validatePassword =
        ValidationService.validatePassword(password);
    Map<String, dynamic> validateConfirmPassword =
        ValidationService.validateConfirmPassword(password, confirmPassword);

    if (validatePhoneNumber['verified']) {
      setState(() {
        phoneNumberValid = true;
      });
    } else {
      setState(() {
        phoneNumberValid = false;
        _phoneNumberErrorText = validateEmail['validatorText'];
      });
    }

    if (validateName['verified']) {
      setState(() {
        nameValid = true;
      });
    } else {
      setState(() {
        nameValid = false;
        _nameErrorText = validateEmail['validatorText'];
      });
    }
    if (validateEmail['verified']) {
      setState(() {
        _emailValid = true;
      });
    } else {
      setState(() {
        _emailValid = false;
        _emailErrorText = validateEmail['validatorText'];
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

    if (validateConfirmPassword['verified']) {
      setState(() {
        _confirmPasswordValid = true;
      });
    } else {
      setState(() {
        _confirmPasswordValid = false;
        _confirmPasswordErrorText = validateConfirmPassword['validatorText'];
      });
    }

    if (_emailValid &&
        _passwordValid &&
        _confirmPasswordValid &&
        nameValid &&
        phoneNumberValid) {
      setState(() {
        isLoading = true;
      });

      UserModel newUser = UserModel(
        name: name,
        phoneNumber: phoneNumber,
        email: email,
        password: password,
        profession: selectProfession!, // Default profession or ask in the form
      );

      final userController =
          Provider.of<UserController>(context, listen: false);
      userController.signUp(newUser); // Save user to Hive and mark as logged in
      final authState = Provider.of<AuthState>(context, listen: false);
      authState.login(); // Update the login status in Hive

      Navigator.pushNamed(context, '/homePage'); // Navigate to HomePage
      // Navigate to the next screen

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
      appBar: AppBar(
        elevation: 0,
        title: txt(
          "Sign Up Page",
          size: sH * 0.028,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: sW * 0.04,
            vertical: sH * 0.02,
          ),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomTextField(
                          title: "Name",
                          hintText: "Name",
                          controller: nameController,
                          maxLines: 1,
                          validate: nameValid,
                          validatorText: _nameErrorText,
                        ),
                        SizedBox(
                          height: sH * 0.02,
                        ),
                        CustomTextField(
                          title: "Phone Number",
                          hintText: "Phone Number",
                          controller: phoneNumberController,
                          maxLines: 1,
                          validate: phoneNumberValid,
                          validatorText: _phoneNumberErrorText,
                        ),
                        SizedBox(
                          height: sH * 0.02,
                        ),
                        _buildDropdownFieldCodeValidity(
                            'Profession', sH, sW), // Dropdown for Code Validity
                        SizedBox(
                          height: sH * 0.02,
                        ),
                        CustomTextField(
                          title: "Email",
                          hintText: "Email",
                          controller: emailController,
                          maxLines: 1,
                          validate: _emailValid,
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
                          height: sH * 0.02,
                        ),
                        CustomTextField(
                          title: "Confirm Password",
                          hintText: "Confirm Password",
                          controller: confirmPasswordController,
                          maxLines: 1,
                          validate: _confirmPasswordValid,
                          validatorText: _confirmPasswordErrorText,
                          obsureText: true,
                          hideText: true,
                        ),
                        SizedBox(
                          height: sH * 0.02,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: _isCheckboxChecked,
                              onChanged: (value) {
                                setState(() {
                                  _isCheckboxChecked = value!;
                                });
                              },
                            ),
                            SizedBox(
                              width: sH * 0.01,
                            ),
                            InkWell(
                              // onTap: _openTermsAndConditions, // Open the link
                              child: txt(
                                "Agree to Terms and Conditions",
                                size: sH * 0.02,
                                color: AppColors.primaryButtonColor,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: sW * 0.14),
                          child: txt(
                            "By clicking this you agree to terms and conditions of WorkWave.",
                            color: AppColors.greyColor,
                          ),
                        ),
                        SizedBox(
                          height: sH * 0.04,
                        ),
                        InkWell(
                          onTap: () async {
                            await _submit(
                                nameController.text,
                                phoneNumberController.text,
                                emailController.text,
                                passwordController.text,
                                confirmPasswordController.text);
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
                              child: isLoading
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : txt(
                                      "Register",
                                      size: sH * 0.021,
                                      color: AppColors.primaryTextColor,
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: sH * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/signinPage');
                              },
                              child: txt(
                                "Already have an account? Sign In",
                                size: sH * 0.02,
                                color: AppColors.whiteTextColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
