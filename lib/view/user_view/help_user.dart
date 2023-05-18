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
      appBar: AppBar(
        elevation: 2,
        // backgroundColor: "#2E4053".toColor(),
        backgroundColor: Colors.white,
        title: const Text(
          'FAQ',
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'Poppins',
            color: Color(0xFF2E4053),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: content(),
      ),
    );
  }

  Widget content() {
    return Container();
  }
}
