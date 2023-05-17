import 'package:flutter/material.dart';

class HelpUser extends StatefulWidget {
  const HelpUser({super.key});

  @override
  State<HelpUser> createState() => _HelpUserState();
}

class _HelpUserState extends State<HelpUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text('PAGE HELP')),
      ),
    );
  }
}
