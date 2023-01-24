import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:message_buddy/screens/register_screen.dart';
import 'package:message_buddy/widgets/button.dart';
import 'package:message_buddy/widgets/constants.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'LoginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool obscureText = false;

// this function is to validate the data entered in the forms.
  login() {
    // if (formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
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
                  'Log in to continue',
                  style: smallHeading,
                ),
                Image.asset('assets/logo.png'),
                SizedBox(
                  height: 1.h,
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
                    setState(() {
                      value = email;
                    });
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
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Password',
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.black38,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        obscureText;
                      },
                      icon: const Icon(
                        Icons.remove_red_eye_sharp,
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
                    setState(() {
                      value = password;
                    });
                  },
                ),
                SizedBox(
                  height: 3.h,
                ),
                Button(
                  action: 'Log in',
                  buttonColor: Colors.blue,
                  onPressed: () {
                    login();
                  },
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text.rich(
                  TextSpan(
                    text: "Don't have an account? ",
                    style: normalText,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Register here',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context)
                                .popAndPushNamed(HomeScreen.routeName);
                          },
                        style: normalText.copyWith(
                            color: Colors.green,
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
}



// a-zA-70-9…a-74-70-9.1#9%¢1*+-/=?1
// {I}~]+@[a-zA-Z0-9]+\. [a-zA-Z]+"

//