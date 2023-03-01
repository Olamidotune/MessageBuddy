import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:message_buddy/screens/group_info_screen.dart';
import 'package:message_buddy/widgets/constants.dart';
import 'package:sizer/sizer.dart';
import '../service/database_service.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = 'ChatScreen';

  final String groupId;
  final String groupName;
  final String userName;

  const ChatScreen(
      {super.key,
      required this.groupId,
      required this.groupName,
      required this.userName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String admin = '';
  Stream<QuerySnapshot>? chats;
  int age = 10;
  String todoText = '';

  @override
  void initState() {
    getChatandAdmin;
    super.initState();
  }

  getChatandAdmin() {
    DataBaseService().getChats(widget.groupId).then((value) {
      setState(() {
        chats = value;
      });
      DataBaseService().getGroupAdmin(widget.groupId).then((value) {
        setState(() {
          admin = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.groupName,
          style: smallHeading.copyWith(
              fontWeight: FontWeight.bold, fontSize: 20.sp),
        ),
        leading: IconButton(
          tooltip: 'Go back to the previous screen',
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            tooltip: 'Group Info',
            onPressed: () {
              nextScreenReplacement(
                  context,
                  GroupInfoScreen(
                    groupId: widget.groupId,
                    userName: widget.userName,
                    groupName: widget.groupName,
                  ));
            },
            icon: const Icon(
              Icons.info_outlined,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(),
    );
  }

  todoPop(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: ((context, setState) {
              return AlertDialog(
                title: Row(
                  children: [],
                ),
                actions: [
                  ElevatedButton(onPressed: () {}, child: const Text('data')),
                  ElevatedButton(onPressed: () {}, child: const Text('done'))
                ],
              );
            }),
          );
        });
  }
}
