import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:message_buddy/service/database_service.dart';
import 'package:message_buddy/widgets/constants.dart';
import 'package:message_buddy/widgets/members_tile.dart';
import 'package:sizer/sizer.dart';

class GroupInfoScreen extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String userName;

  const GroupInfoScreen(
      {super.key,
      required this.groupId,
      required this.groupName,
      required this.userName});

  @override
  State<GroupInfoScreen> createState() => _GroupInfoScreenState();
}

class _GroupInfoScreenState extends State<GroupInfoScreen> {
  Stream? members;
  @override
  void initState() {
    getMembers();
    super.initState();
  }

  void getMembers() async {
    DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getGroupMembers(widget.groupId)
        .then((value) {
      setState(() {
        members = value;
      });
    });
  }

  String getName(String r) {
    return r.substring(r.indexOf('_') + 1);
  }

  String getId(String res) {
    return res.substring(0, res.indexOf('_'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Group Info',
          style: smallHeading.copyWith(
              fontWeight: FontWeight.bold, fontSize: 20.sp),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.black,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 30,
                    child: Text(
                      widget.groupName.substring(0, 1).toUpperCase(),
                      style: smallHeading.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Group: ${widget.groupName}", style: smallHeading),
                      Text('Admin: ${widget.userName}', style: smallHeading),
                    ],
                  ),
                ],
              ),
            ),
            memberList()
          ],
        ),
      ),
    );
  }

  memberList() {
    return StreamBuilder(
      stream: members,
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['members'] != null) {
            if (snapshot.data['members'].length != 0) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data['members'].length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        child: Text(
                          widget.userName.substring(0, 1).toUpperCase(),
                          style: smallHeading,
                        ),
                      ),
                      title: Text(
                        getName(
                          snapshot.data['members'][index],
                        ),
                      ),
                      subtitle: const Text('Member'),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('There are no members'));
            }
          } else {
            return const Center(child: Text('There are no members'));
          }
        } else {
          return const CircularProgressIndicator(
            color: Colors.blue,
          );
        }
      },
    );
  }
}
