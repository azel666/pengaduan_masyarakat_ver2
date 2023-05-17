import 'package:flutter/material.dart';

class FeedUser extends StatefulWidget {
  const FeedUser({super.key});

  @override
  State<FeedUser> createState() => _FeedUserState();
}

class _FeedUserState extends State<FeedUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text('PAGE FEED')),
      ),
    );
  }
}
