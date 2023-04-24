import 'package:flutter/material.dart';
import 'package:message_buddy/widgets/constants.dart';
import 'package:sizer/sizer.dart';

class MessagesTile extends StatefulWidget {
  final String message;
  final String sender;
  final bool sentByMe;
  const MessagesTile(
      {super.key,
      required this.sender,
      required this.message,
      required this.sentByMe});

  @override
  State<MessagesTile> createState() => _MessagesTileState();
}

class _MessagesTileState extends State<MessagesTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.sentByMe ? Colors.red : Colors.green,
      ),
      width: double.infinity,
      child: Column(
        children: [
          Text(
         widget.sender,
            style: smallHeading,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            widget.message,
            style: smallHeading,
          ),
        ],
      ),
    );
  }
}
