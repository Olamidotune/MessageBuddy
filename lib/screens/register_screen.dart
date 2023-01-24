import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:message_buddy/auth/login_screen.dart';
import 'package:message_buddy/widgets/constants.dart';
import 'package:sizer/sizer.dart';

import '../widgets/button.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final formKey = GlobalKey<FormState>();
  String fullName = '';
  String email = '';
  String password = '';
  bool obscureText = true;

  register() {}

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
                    setState(() {
                      value = fullName;
                    });
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
                    text: "Already have an account?  ",
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
}
