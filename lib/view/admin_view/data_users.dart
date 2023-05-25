import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pengaduan_masyarakat_ver2/widget/data_users_card.dart';

class DataUsers extends StatefulWidget {
  const DataUsers({super.key});

  @override
  State<DataUsers> createState() => _DataUsersState();
}

class _DataUsersState extends State<DataUsers> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference data = firestore.collection("users");
    return data.orderBy("createdAt", descending: true).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        // backgroundColor: "#2E4053".toColor(),
        backgroundColor: Colors.white,
        title: const Text(
          'Data User',
          style: TextStyle(
            fontSize: 22,
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
            return DataUsersCard(
              listAllDocs: listAllDocument,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
