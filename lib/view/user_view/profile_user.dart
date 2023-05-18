import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pengaduan_masyarakat_ver2/view/intro_view/login.dart';

class ProfileUser extends StatefulWidget {
  const ProfileUser({super.key});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  String? uName = "";
  String? uEmail = "";
  String? uPhone = "";
  String? uImage = "";

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
              fontSize: 25,
              fontFamily: 'Poppins',
              color: Color(0xFF2E4053),
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            // IconButton(
            //     onPressed: logout,
            //     icon: Icon(
            //       Icons.menu,
            //       color: Color(0xFF2E4053),
            //     ))
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
                // Lakukan sesuatu berdasarkan item yang dipilih
                if (value == 'edit_profile') {
                  // Tindakan untuk Edit Profile
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
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      padding: const EdgeInsets.only(right: 20, left: 20, top: 40),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 70.0,
            backgroundColor: Colors.grey,
            // backgroundImage: uImage == null
            //     ? Image.asset("assets/images/test.jpg").image
            //     : Image.network(uImage!).image,
          ),
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
                          uName!,
                          style: const TextStyle(
                            color: Color(0xFF2E4053),
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
                            uEmail!,
                            style: const TextStyle(
                              color: Color(0xFF2E4053),
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
                            Icons.phone,
                            color: Color(0xFF2E4053),
                            size: 30,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            uPhone!,
                            style: const TextStyle(
                              color: Color(0xFF2E4053),
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
          uImage = snapshot.data()!['image'];
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
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
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
