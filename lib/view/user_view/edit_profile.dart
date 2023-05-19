import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pengaduan_masyarakat_ver2/resource/firestore_method.dart';
import 'package:pengaduan_masyarakat_ver2/view/user_view/profile_user.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  TextEditingController uName = TextEditingController();
  TextEditingController uEmail = TextEditingController();
  TextEditingController uPhone = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1,
          // backgroundColor: "#2E4053".toColor(),
          backgroundColor: Colors.white,
          title: const Text(
            'Edit Profile',
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'Poppins',
              color: Color(0xFF2E4053),
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: IconThemeData(color: Color(0xFF2E4053)),
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
              backgroundImage: AssetImage('assets/images/default_user.png')
              // backgroundImage: uImage == null
              //     ? Image.asset("assets/images/test.jpg").image
              //     : Image.network(uImage!).image,
              ),
          ElevatedButton(
            onPressed: () {},
            child: Icon(Icons.camera_alt),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xFF2E4053)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 350,
            padding: const EdgeInsets.only(
              top: 50,
              right: 20,
              left: 20,
            ),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextFormField(
                  controller: uName,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_2_outlined)),
                ),
                TextFormField(
                  controller: uEmail,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                  decoration:
                      InputDecoration(prefixIcon: Icon(Icons.email_outlined)),
                ),
                TextFormField(
                  controller: uPhone,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                  decoration:
                      InputDecoration(prefixIcon: Icon(Icons.phone_outlined)),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    await FirestoreMethod()
                        .updateUser(uid, uName.text, uEmail.text, uPhone.text);
                    showUpdateDataSuccessDialog();
                  },
                  icon: Icon(Icons.save),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFF2E4053)),
                  ),
                  label: Text(
                    'Simpan',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future getData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((snap) {
      if (snap.exists) {
        String username = snap.get('username');
        String email = snap.get('email');
        String phone = snap.get('noTelp');
        setState(() {
          uName.text = username;
          uEmail.text = email;
          uPhone.text = phone;
        });
      }
    });
  }

  void showUpdateDataSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'update data',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Data berhasil diubah',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text(
                'OK',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Get.offAll(ProfileUser());
              },
            ),
          ],
        );
      },
    );
  }
}
