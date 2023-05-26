import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pengaduan_masyarakat_ver2/resource/auth_method.dart';
import 'package:pengaduan_masyarakat_ver2/resource/firestore_method.dart';
import 'package:pengaduan_masyarakat_ver2/shared/my_color.dart';
import 'package:pengaduan_masyarakat_ver2/view/admin_view/dashboard_admin.dart';
import 'package:pengaduan_masyarakat_ver2/view/intro_view/register.dart';
import 'package:pengaduan_masyarakat_ver2/view/user_view/dashboard_user.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController emailCon = TextEditingController();
  TextEditingController passCon = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    emailCon.dispose();
    passCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Center(child: content()),
      ),
    );
  }

  Widget content() {
    return Container(
      height: 600,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 50,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    'Platform Layanan Pengaduan Banjarnegara',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 22),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  child: TextFormField(
                    controller: emailCon,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.person_outline),
                        label: Text('Email',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                            )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "masukkan email";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: TextFormField(
                    obscureText: true,
                    controller: passCon,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.lock),
                        label: Text('Password',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                            )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "masukkan password";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 75,
                  padding: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xFF2E4053)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ))),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        loginUser();
                      }
                    },
                    child: Text('Login',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Belum punya akun? ',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                          )),
                      InkWell(
                        onTap: () {
                          Get.to(Register());
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                              color: "#99A3A4".toColor(),
                              fontFamily: 'Poppins'),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });

    try {
      String res = await AuthMethod()
          .login(email: emailCon.text, password: passCon.text);
      if (res == 'Success') {
        route();
        setState(() {
          _isLoading = false;
        });
      } else {
        loginFailed();
        setState(() {
          _isLoading = false;
        });
      }
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  // rute login
  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('role') == "user") {
          Get.off(const DashboardUser());
        } else {
          Get.off(const DashboardAdmin());
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  void loginFailed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Gagal login',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'username atau password salah',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF2E4053)),
              ),
              child: Text(
                'OK',
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
