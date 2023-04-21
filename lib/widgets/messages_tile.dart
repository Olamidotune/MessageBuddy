import 'package:flutter/material.dart';

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
      decoration:
          BoxDecoration(color: widget.sentByMe ? Colors.red : Colors.green),
      child: Text(
        widget.sender.toUpperCase(),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
