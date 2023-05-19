import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:pengaduan_masyarakat_ver2/resource/firestore_method.dart';
import 'package:pengaduan_masyarakat_ver2/resource/storage_method.dart';
import 'package:pengaduan_masyarakat_ver2/shared/my_color.dart';
import 'package:pengaduan_masyarakat_ver2/view/user_view/dashboard_user.dart';

class TambahAduan extends StatefulWidget {
  const TambahAduan({super.key});

  @override
  State<TambahAduan> createState() => _TambahAduanState();
}

class _TambahAduanState extends State<TambahAduan> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController dateInput = TextEditingController();
  TextEditingController judulCon = TextEditingController();
  TextEditingController deskCon = TextEditingController();
  TextEditingController locCon = TextEditingController();
  TextEditingController _imageController = TextEditingController();
  bool isLoading = false;
  XFile? _img;
  String imgUrl = "";
  String? uName = "";
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // bool _isImageUploaded = false;
  @override
  void initState() {
    // userId = FirebaseAuth.instance.currentUser;
    dateInput.text = "";
    judulCon.text = "";
    deskCon.text = "";
    locCon.text = ""; //set the initial value of text field
    super.initState();
    getDataUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFF2E4053),
        ),
        elevation: 2,
        title: const Text(
          'Tambah Aduan',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E4053),
          ),
        ),
        // backgroundColor: "#34495E".toColor(),
        backgroundColor: Colors.white,
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.all(15.0),
        // color: "#212F3C".toColor(),
        child: Center(
          child: content(),
        ),
      ),
    );
  }

  Widget content() {
    return Container(
        child: PhysicalModel(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: "#EAECEE".toColor(),
      elevation: 3,
      child: Container(
          padding: EdgeInsets.all(15.0),
          width: MediaQuery.of(context).size.width,
          height: 600,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: TextFormField(
                    controller: judulCon,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        label: Text('Judul',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                            )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return null;
                      } else {
                        return "judul tidak boleh kosong";
                      }
                    },
                  ),
                ),
                Container(
                  child: TextFormField(
                    controller: deskCon,
                    maxLines: 4,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        label: Text('Deskripsi',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                            )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "deskripsi tidak boleh kosong";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "tanggal tidak boleh kosong";
                      } else {
                        return null;
                      }
                    },
                    controller: dateInput,
                    //editing controller of this TextField
                    decoration: InputDecoration(
                      label: Text('Tanggal',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                          )),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      prefixIcon: Icon(
                          color: Colors.lightBlue,
                          Icons.calendar_today_outlined),
                      //icon of text field
                      //label text of field
                    ),
                    readOnly: true,
                    //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2022),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2100));

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate = DateFormat(
                          'dd MMMM yyyy',
                        ).format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        setState(() {
                          dateInput.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {}
                    },
                  ),
                ),
                Container(
                  child: TextFormField(
                    controller: locCon,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        label: Text('Lokasi',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                            )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "lokasi tidak boleh kosong";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: SizedBox(
                      height: 55,
                      child: TextFormField(
                        enabled: false,
                        readOnly: true,
                        controller: _imageController,
                        decoration: InputDecoration(
                            hintText: 'foto belum diupload',
                            hintStyle: TextStyle(fontFamily: 'Poppins'),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ))),
                      ),
                    )),
                    Container(
                      height: 55,
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all("#85929E".toColor()),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ))),
                        onPressed: () async {
                          final ImagePicker _picker = ImagePicker();
                          XFile? img = await _picker.pickImage(
                              source: ImageSource.gallery);
                          if (img != null) {
                            setState(() {
                              _img = img;
                            });
                            _imageController.text = img.name;
                          }
                        },
                        icon: Icon(Icons.photo_camera),
                        label: Text(
                          'Upload',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                        // child: Text('Upload photo',
                        //     style: TextStyle(
                        //         fontFamily: 'Poppins',
                        //         fontSize: 20,
                        //         fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all("#2ECC71".toColor()),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // addData(judulCon.text, deskCon.text, locCon.text,
                        //     dateInput.text, _img!);

                        // showAddDataSuccessDialog();
                        addAduan(_img!);
                      }
                    },
                    child: Text('Tambah',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
          )),
    ));
  }

  void addAduan(XFile image) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDir = referenceRoot.child('aduan');
    Reference referenceImageUpload = referenceDir.child(fileName);
    try {
      await referenceImageUpload.putFile(File(image.path));
      imgUrl = await referenceImageUpload.getDownloadURL();

      final FirebaseAuth auth = FirebaseAuth.instance;
      String uid = auth.currentUser!.uid.toString();
      await FirestoreMethod().addAduan(judulCon.text, deskCon.text, locCon.text,
          uName!, imgUrl, dateInput.text, uid);
      showAddDataSuccessDialog();
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  // void clearImage() {
  //   setState(() {
  //     _file = null;
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
    judulCon.dispose();
    deskCon.dispose();
    locCon.dispose();
    dateInput.dispose();
  }

  void showAddDataSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'data upload',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Data berhasil ditambahkan',
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
                Get.offAll(DashboardUser());
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> getDataUser() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    await firestore.collection('users').doc(uid).get().then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          uName = snapshot.data()!['username'];
        });
      }
    });
  }
}
