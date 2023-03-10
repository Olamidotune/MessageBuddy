import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:message_buddy/helper/helper_functions.dart';
import 'package:message_buddy/service/database_service.dart';
import 'package:message_buddy/widgets/constants.dart';
import 'package:sizer/sizer.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = 'Search Screen';

  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  QuerySnapshot? searchSnapShot;
  bool hasUserSearch = false;
  String userName = '';
  bool isJoined = false;

  User? user;

  //string manipulation
  String getId(String res) {
    return res.substring(0, res.indexOf('_'));
  }

  String getName(String res) {
    return res.substring(res.indexOf('_') + 1);
  }

  @override
  void initState() {
    super.initState();
    getCurrentUserNameAndId();
  }

  getCurrentUserNameAndId() async {
    await HelperFunctions.getUserNamefromSF().then((value) {
      setState(() {
        userName = value!;
      });
    });
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Search ',
          style: smallHeading.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: TextEditingController(),
                    decoration: const InputDecoration(
                      fillColor: Colors.white24,
                      hoverColor: Colors.yellow,
                      hintText: 'Search for groups',
                      // errorText: 'There is no group with that name found.',
                    ),
                    onChanged: (value) {
                      searchController.text = value;
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    print('object');
                    initiateSearchMethod();
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.black54,
                    ),
                    child: const Icon(
                      Icons.search,
                      size: 25,
                    ),
                  ),
                )
              ],
            ),
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : groupList(),
        ],
      ),
    );
  }

  initiateSearchMethod() async {
    if (searchController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await DataBaseService()
          .searchByName(searchController.text)
          .then((snapshot) {
        setState(() {
          searchSnapShot = snapshot;
          isLoading = false;
          hasUserSearch = true;
        });
      });
    }
  }

  groupList() {
    return hasUserSearch
        ? ListView.builder(
            itemCount: searchSnapShot!.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return groupTile(
                userName,
                searchSnapShot!.docs[index]['admin'],
                searchSnapShot!.docs[index]['groupId'],
                searchSnapShot!.docs[index]['groupName'],
              );
            },
          )
        : Container();
  }

  userJoinedOrNot(
      String userName, String groupId, String groupName, String admin) async {
    await DataBaseService(uid: user!.uid)
        .isUserJoined(groupId, groupName, userName)
        .then((value) {
      setState(() {
        isJoined = value;
      });
    });
  }

  Widget groupTile(
      String userName, String admin, String groupId, String groupName) {
    userJoinedOrNot(userName, groupId, groupName, admin);
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.black,
        child: Text(
          groupName.substring(0, 1).toUpperCase(),
          style: smallHeading,
        ),
      ),
      title: Text(
        groupName,
        style: smallHeading,
      ),
      subtitle: Text(
        'Admin: ${getName(admin)}',
        style: normalText,
      ),
      trailing: InkWell(
          onTap: () async {},
          child: isJoined
              ? Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black),
                  child: Center(
                      child: Text(
                    'Joined',
                    style: normalText,
                  )))
              : Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black),
                child: Center(
                  child: Text(
                    'Join Group',
                    style: normalText,
                  ),
                ),
              )),
    );
  }
}
