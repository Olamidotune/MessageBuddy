// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:message_buddy/auth/login_screen.dart';
import 'package:message_buddy/helper/helper_functions.dart';
import 'package:message_buddy/screens/profile_screen.dart';
import 'package:message_buddy/screens/search_screen.dart';
import 'package:message_buddy/service/auth_service.dart';
import 'package:message_buddy/service/database_service.dart';
import 'package:message_buddy/widgets/constants.dart';
import 'package:message_buddy/widgets/snackbar.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'Home Screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthService authService = AuthService();
  String userName = '';
  String email = '';
  Stream? groups;
  final bool _isLoading = false;
  String groupName = '';

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  gettingUserData() async {
    await HelperFunctions.getUserEmailfromSF().then((value) {
      setState(() {
        email = value!;
      });
    });

    await HelperFunctions.getUserNamefromSF().then((value) {
      setState(() {
        userName = value!;
      });
    });

// getting the list of snapshot in our stream.
    await DataBaseService(uid: FirebaseAuth.instance.currentUser?.uid)
        .getUserGroups()
        .then((snapshot) {
      groups = snapshot;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        elevation: 20,
        width: 55.w,
        child: ListView(
          children: <Widget>[
            const Icon(Icons.account_circle, size: 50),
            SizedBox(
              height: 1.h,
            ),
            Text(
              userName,
              style: smallHeading.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 1.h,
            ),
            const Divider(
              thickness: 2,
              color: Colors.black,
            ),
            DrawerButton(
              selected: true,
              icon: Icons.group,
              action: 'Groups',
              onTap: () {},
            ),
            SizedBox(
              height: 1.h,
              child: Divider(
                thickness: 1,
                color: Colors.black54,
              ),
            ),
            DrawerButton(
              selected: false,
              icon: Icons.account_circle_sharp,
              action: 'Profile',
              onTap: () {
                Navigator.of(context).popAndPushNamed(ProfileScreen.routeName);
              },
            ),
            SizedBox(
              height: 1.h,
              child: Divider(
                thickness: 1,
                color: Colors.black54,
              ),
            ),
            DrawerButton(
              icon: Icons.logout,
              action: 'Logout',
              onTap: () async {
                myDialog(context);
              },
              selected: false,
            ),
            SizedBox(
              height: 1.h,
              child: Divider(
                thickness: 1,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('Message Buddy',
            style:
                heading.copyWith(fontWeight: FontWeight.bold, fontSize: 20.sp)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(SearchScreen.routeName);
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      body: groupList(),
      floatingActionButton: FloatingActionButton(
        elevation: 20,
        tooltip: 'Add groups',
        backgroundColor: Colors.white30,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
        onPressed: () {
          popUpDialog(context);
        },
      ),
    );
  }

  popUpDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, stateState) {
          return AlertDialog(
            title: Row(
              children: [
                Icon(Icons.group_rounded),
                SizedBox(
                  width: 3.w,
                ),
                Text(
                  'Create a group',
                  style: normalText,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            content: _isLoading == true
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        onChanged: (value) {
                          groupName = value;
                          print(groupName);
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.circular(
                              30,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(
                              30,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.circular(
                              30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: buttonText,
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(),
                onPressed: () async {
                  if (groupName != '') {
                    setState(() {
                      _isLoading == true;
                    });
                    DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                        .createGroup(
                      userName,
                      FirebaseAuth.instance.currentUser!.uid,
                      groupName,
                    )
                        // ignore: void_checks
                        .whenComplete(() {
                      return _isLoading;
                    });
                    Navigator.of(context).pop();
                    showSnackBar(
                        context, Colors.green, 'Group created successfully');
                  }
                },
                child: Text(
                  'Create Group',
                  style: buttonText,
                ),
              ),
            ],
          );
        });
      },
    );
  }

  groupList() {
    return StreamBuilder(
      stream: groups,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['groups'] != null) {
            if (snapshot.data['groups'].length != 0) {
              return Text('Hello, Welcome...');
            } else {
              return noGroupWidget();
            }
          } else {
            return noGroupWidget();
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.green,
            ),
          );
        }
      },
    );
  }

  noGroupWidget() {
    return Container(
      padding: EdgeInsets.all(30),
      child: Center(
        child: Text(
          'Welcome $userName 👋🏾 . Click on the ➕ button to create a group or the 🔎 button to search for a group.',
          style: normalText,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Future<dynamic> myDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Logout'),
            content: const Text(
              'Are you sure you want to logout?',
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: () async {
                  await authService.signOut();

                  if (!mounted) return;
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (route) => false);
                },
                icon: const Icon(
                  Icons.done,
                  color: Colors.green,
                ),
              )
            ],
          );
        });
  }
}

class DrawerButton extends StatelessWidget {
  final IconData icon;
  final String action;
  final VoidCallback onTap;
  final bool selected;

  const DrawerButton(
      {super.key,
      required this.icon,
      required this.action,
      required this.onTap,
      required this.selected});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: selected,
      selectedColor: Colors.black,
      splashColor: Colors.black,
      onTap: onTap,
      leading: Icon(icon),
      title: Text(
        action,
        style: normalText,
      ),
    );
  }
}


