import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:message_buddy/auth/login_screen.dart';
import 'package:message_buddy/helper/helper_functions.dart';
import 'package:message_buddy/screens/home_screen.dart';
import 'package:message_buddy/service/auth_service.dart';
import 'package:message_buddy/widgets/constants.dart';
import 'package:message_buddy/widgets/snackbar.dart';
import 'package:sizer/sizer.dart';

import '../widgets/button.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'RegisterScreen';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String fullName = '';
  String email = '';
  String password = '';
  bool passwordObscureText = true;
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.black,
                semanticsLabel: 'Please wait',
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Message Buddy',
                          style: heading,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        'Create your account now to chat and explore',
                        style: smallHeading,
                      ),
                      Image.asset('assets/logo.png'),
                      TextFormField(
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Fullname',
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.black38,
                          ),
                        ),
                        onChanged: (value) {
                          fullName = value;
                        },
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            return null;
                          } else {
                            return 'Fullname cannot be empty';
                          }
                        },
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      TextFormField(
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Email',
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.black38,
                          ),
                        ),
                        onChanged: (value) {
                          email = value;
                        },
                        validator: (value) {
                          return RegExp(
                            (r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"),
                          ).hasMatch(value!)
                              ? null
                              : 'Please enter a valid e-mail';
                        },
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      TextFormField(
                        obscureText: passwordObscureText,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Password',
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.black38,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(
                                () {
                                  passwordObscureText = !passwordObscureText;
                                },
                              );
                            },
                            icon: passwordObscureText
                                ? const Icon(
                                    Icons.visibility_rounded,
                                    color: Colors.black38,
                                  )
                                : const Icon(
                                    Icons.visibility_off_outlined,
                                    color: Colors.black38,
                                  ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'Password should be at least 6 charaters';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Button(
                        action: 'Register',
                        buttonColor: Colors.green,
                        onPressed: () {
                          register();
                        },
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text.rich(
                        TextSpan(
                          text: "Already have an account?",
                          style: normalText,
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Log in now.',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context)
                                      .popAndPushNamed(LoginScreen.routeName);
                                },
                              style: normalText.copyWith(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w900,
                                  decoration: TextDecoration.underline),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailandPassword(fullName, email, password)
          .then((value) async {
        if (value == true) {
          //saving the shared prefrence state.
          //by using the shared prefrence, the userLoggedInStatus is saved on the phone...
          //so the user only have to logged in once.
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(fullName);
          if (!mounted) return;
          Navigator.of(context).popAndPushNamed(HomeScreen.routeName);
        } else {
          showSnackBar(context, Colors.red, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}
