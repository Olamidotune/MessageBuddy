import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:message_buddy/auth/login_screen.dart';
import 'package:message_buddy/service/auth_service.dart';

class TestingScreen extends StatefulWidget {
  static const String routeName = 'Testing Screen';
  const TestingScreen({super.key});

  @override
  State<TestingScreen> createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            authService.signOut();
            Navigator.of(context).popAndPushNamed(LoginScreen.routeName);
          },
          icon: const Icon(Icons.logout),
        ),
      ),
      body: const Center(
        child: Text('Testing Screen'),
      ),
    );
  }
}
