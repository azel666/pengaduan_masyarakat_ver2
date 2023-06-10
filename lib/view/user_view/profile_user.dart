import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pengaduan_masyarakat_ver2/view/admin_view/dashboard_admin.dart';

import 'package:pengaduan_masyarakat_ver2/view/intro_view/login.dart';
import 'package:pengaduan_masyarakat_ver2/view/user_view/edit_profile.dart';

class ProfileUser extends StatefulWidget {
  const ProfileUser({super.key});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  final _firestore = FirebaseFirestore.instance;
  String? uName = "";
  String? uEmail = "";
  String? uPhone = "";
  String uImage = "";

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var appBarHeight = AppBar().preferredSize.height;
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          // backgroundColor: "#2E4053".toColor(),
          backgroundColor: Colors.white,
          title: const Text(
            'Profile',
            style: TextStyle(
              fontSize: 22,
              fontFamily: 'Poppins',
              color: Color(0xFF2E4053),
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            PopupMenuButton<String>(
              offset: Offset(0.0, appBarHeight),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
              ),
              onSelected: (value) {
                if (value == 'edit_profile') {
                  Get.to(EditProfile());
                } else if (value == 'logout') {
                  logout();
                }
              },

              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                      value: 'edit_profile',
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: Colors.black54,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Edit Profile',
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                        ],
                      )),
                  const PopupMenuItem<String>(
                      value: 'logout',
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.black54,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Logout',
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                        ],
                      )),
                ];
              },
              iconSize: 30,
              icon: const Icon(Icons.menu,
                  color: Color(0xFF2E4053)), // Ikonya di sini
            ),
          ],
        ),
        body: content());
  }

  Widget content() {
    return StreamBuilder(
        stream: _firestore.collection('users').doc(uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            padding: const EdgeInsets.only(right: 20, left: 20, top: 40),
            child: Column(
              children: [
                CircleAvatar(
                    radius: 70.0,
                    backgroundColor: Colors.grey,
                    backgroundImage: uImage == ""
                        ? AssetImage('assets/images/default_user.png')
                        : Image.network(
                            snapshot.data!.data()!['imageUrl'],
                          ).image),
                Container(
                  padding: const EdgeInsets.only(
                    top: 50,
                    right: 20,
                    left: 20,
                  ),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.person_outline,
                                color: Color(0xFF2E4053),
                                size: 30,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                snapshot.data!.data()!['username'],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(
                            thickness: 1,
                            color: Colors.black26,
                            height: 1,
                            indent: 45,
                          ),
                        ],
                      )),
                      Container(
                        padding: const EdgeInsets.only(top: 40),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.email_outlined,
                                  color: Color(0xFF2E4053),
                                  size: 30,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  snapshot.data!.data()!['email'],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Divider(
                              thickness: 1,
                              color: Colors.black26,
                              height: 1,
                              indent: 45,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 40),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.phone_outlined,
                                  color: Color(0xFF2E4053),
                                  size: 30,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  snapshot.data!.data()!['noTelp'],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Divider(
                              thickness: 1,
                              color: Colors.black26,
                              height: 1,
                              indent: 45,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> getData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          uName = snapshot.data()!['username'];
          uEmail = snapshot.data()!['email'];
          uPhone = snapshot.data()!['noTelp'];
          uImage = snapshot.data()!['imageUrl'];
        });
      }
    });
  }

  void logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Logout',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Apakah anda ingin keluar?',
            style: TextStyle(
              fontFamily: 'Poppins',
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF2E4053)),
              ),
              child: const Text(
                'Ya',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Get.deleteAll();
                Get.offAll(const Login());
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF2E4053)),
              ),
              child: const Text(
                'Tidak',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}
