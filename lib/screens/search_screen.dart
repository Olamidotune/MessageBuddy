import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:message_buddy/widgets/constants.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = 'Search Screen';

  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Text(
        'Search Screen',
        style: heading,
      )),
    );
  }
}
