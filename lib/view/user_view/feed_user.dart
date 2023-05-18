import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pengaduan_masyarakat_ver2/shared/my_color.dart';
import 'package:pengaduan_masyarakat_ver2/widget/feed_card.dart';

class FeedUser extends StatefulWidget {
  const FeedUser({super.key});

  @override
  State<FeedUser> createState() => _FeedUserState();
}

class _FeedUserState extends State<FeedUser> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference data = firestore.collection("aduan");
    return data.orderBy("datePublished", descending: true).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        // backgroundColor: "#2E4053".toColor(),
        backgroundColor: Colors.white,
        title: const Text(
          'Feed',
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
    return StreamBuilder<QuerySnapshot<Object?>>(
        stream: streamData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var listAllDocument = snapshot.data!.docs;
            return FeedCard(listAllDocument: listAllDocument);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
