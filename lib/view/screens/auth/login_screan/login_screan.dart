// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sahra/core/constants/constants_properties.dart';
import 'package:sahra/core/constants/font_constant.dart';
import 'package:sahra/core/firebase/firebase_service.dart';
import 'package:sahra/view/pub_widgets/elements/background_widget.dart';
import 'package:sahra/view/pub_widgets/elements/top_snake_bar.dart';
import 'package:sahra/view/pub_widgets/pub_widgets_lite/customTextField.dart';
import 'package:sahra/view/pub_widgets/pub_widgets_lite/passwordTxTfield.dart';

class LoginScrean extends StatefulWidget {
  const LoginScrean({super.key});

  @override
  State<LoginScrean> createState() => _LogInScreanState();
}

class _LogInScreanState extends State<LoginScrean> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _auth = AuthService();
bool isLoading = false;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      try {
        await _auth.loginUser(emailController.text, passwordController.text);
        // Only show the 'Login successful!' message when the login operation is successful
        showTopSnackBar(context, 'Login successful!', Colors.green);
        GoRouter.of(context).pop();
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        switch (e.code) {
          case 'user-not-found':
            errorMessage = 'No user found with this email address.';
            break;
          case 'wrong-password':
            errorMessage = 'Incorrect password. Please try again.';
            break;
          case 'invalid-email':
            errorMessage = 'The email address entered is not valid.';
            break;
          case 'user-disabled':
            errorMessage = 'This account has been disabled. Please contact support.';
            break;
          case 'too-many-requests':
            errorMessage = 'Too many login attempts. Please try again later.';
            break;
          case 'operation-not-allowed':
            errorMessage =
                'Email/password accounts are not enabled. Please contact support.';
            break;
          default:
            errorMessage = 'An unknown error occurred. Please try again.';
        }
        // Show error message on failure
        showTopSnackBar(context, errorMessage, Colors.red);
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          const BackgroundWidget(),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              blurRadius: 6,
                              spreadRadius: 3,
                              offset: Offset(0, 0),
                            )
                          ]),
                      child: const CircleAvatar(
                        radius: 90,
                        backgroundImage: AssetImage(klogo2),
                      ),
                    ),
                    CustomTextField(
                      isEmail: true,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email address';
                        }
                        final emailRegex = RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                        if (!emailRegex.hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      hintText: '***@gmail.com',
                      prefixIcon: const Icon(Icons.mail, color: Colors.grey),
                      controller: emailController,
                    ),
                    // Password field
                    PasswordTextField(
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                      hintText: 'Password',
                      controller: passwordController,
                    ),
                    // Confirm password field

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'You Don\'t Have Account ?  ',
                          style: mainfont1.copyWith(fontSize: 18),
                        ),
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context).pop();
                          },
                          child: Text(
                            'Make Account',
                            style: mainfont1.copyWith(
                                color: Colors.blueAccent, fontSize: 18),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 50),
                    // Submit button
                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: const Size.fromHeight(50),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                     child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('LogIn', style: TextStyle(fontFamily: kmainfont2)),

                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 20,
            child: IconButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
        ],
      ),
    );
  }
}
