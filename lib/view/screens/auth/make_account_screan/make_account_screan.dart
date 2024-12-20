import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sahra/core/constants/constants_properties.dart';
import 'package:sahra/core/constants/font_constant.dart';
import 'package:sahra/core/firebase/firebase_service.dart';
import 'package:sahra/core/routes/app_routes.dart';
import 'package:sahra/view/pub_widgets/elements/background_widget.dart';
import 'package:sahra/view/pub_widgets/elements/top_snake_bar.dart';
import 'package:sahra/view/pub_widgets/pub_widgets_lite/customTextField.dart';
import 'package:sahra/view/pub_widgets/pub_widgets_lite/passwordTxTfield.dart';

class BuildAccountScrean extends StatefulWidget {
  const BuildAccountScrean({super.key});

  @override
  State<BuildAccountScrean> createState() => _BuildAccountScreanState();
}

class _BuildAccountScreanState extends State<BuildAccountScrean> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();
  final _auth = AuthService();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.createUser(emailController.text, passwordController.text);
        showTopSnackBar(
            context, 'You successfully created an account!', Colors.green);
        GoRouter.of(context).pop(); // Navigate back after success
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        switch (e.code) {
          case 'weak-password':
            errorMessage = 'The password provided is too weak.';
            break;
          case 'email-already-in-use':
            errorMessage = 'The account already exists for that email.';
            break;
          case 'invalid-email':
            errorMessage = 'The email address is not valid.';
            break;
          default:
            errorMessage = 'An unknown error occurred. Please try again.';
        }
        showTopSnackBar(context, errorMessage, Colors.red);
      } catch (e) {
        showTopSnackBar(
            context, 'Network error. Please try again.', Colors.red);
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
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
                  children: [
                    // Profile image
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
                    // Name field
                    CustomTextField(
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      hintText: 'User name',
                      prefixIcon: const Icon(Icons.person),
                      controller: nameController,
                    ),
                    // Email field
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
                    PasswordTextField(
                      validate: (value) {
                        if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      hintText: 'Confirm password',
                      controller: confirmpasswordController,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'You Have Account ?  ',
                          style: mainfont1.copyWith(fontSize: 20),
                        ),
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context).push(AppRoutes.lns);
                          },
                          child: Text(
                            'LogIn',
                            style: mainfont1.copyWith(
                                color: Colors.blueAccent, fontSize: 20),
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
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: kmainfont,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
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
