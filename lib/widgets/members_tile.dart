import 'package:flutter/material.dart';

import 'constants.dart';

class MembersTile extends StatefulWidget {
  final String userName;
  final String groupId;
  final String groupName;
  const MembersTile(
      {super.key,
      required this.userName,
      required this.groupId,
      required this.groupName});

  @override
  State<MembersTile> createState() => _MembersTileState();
}

class _MembersTileState extends State<MembersTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          child: Text(
            widget.groupName.substring(0, 1).toUpperCase(),
            style: smallHeading,
          ),
        ),
        title: Text(
          widget.groupName,
          style: smallHeading,
        ),
        subtitle: Text(
          'Join as the conversation as ${widget.userName}',
          style: normalText,
        ),
      ),
    );
  }
}
