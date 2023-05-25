import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pengaduan_masyarakat_ver2/resource/firestore_method.dart';
import 'package:pengaduan_masyarakat_ver2/view/admin_view/data_users.dart';

class DataUserDetail extends StatefulWidget {
  final detail;
  const DataUserDetail({required this.detail, super.key});

  @override
  State<DataUserDetail> createState() => _DataUserDetailState();
}

class _DataUserDetailState extends State<DataUserDetail> {
  @override
  Widget build(BuildContext context) {
    var appBarHeight = AppBar().preferredSize.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1,
          // backgroundColor: "#2E4053".toColor(),
          backgroundColor: Colors.white,
          title: const Text(
            'Detail User',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Poppins',
              color: Color(0xFF2E4053),
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: IconThemeData(color: Color(0xFF2E4053)),
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
              onSelected: (value) async {
                if (value == 'edit_role') {
                  editRole();
                } else if (value == 'delete_user') {
                  showDelete();
                }
              },

              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                      value: 'edit_role',
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
                            'Edit Role',
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                        ],
                      )),
                  const PopupMenuItem<String>(
                      value: 'delete_user',
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.black54,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Delete User',
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
          CircleAvatar(
              radius: 70.0,
              backgroundColor: Colors.grey,
              backgroundImage: widget.detail['imageUrl'] == ""
                  ? AssetImage('assets/images/default_user.png')
                  : Image.network(widget.detail['imageUrl']).image),
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
                          widget.detail['username'],
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
                            widget.detail['email'],
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
                            widget.detail['noTelp'],
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
                ),
                Container(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.done,
                            color: Color(0xFF2E4053),
                            size: 30,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            widget.detail['createdAt'],
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
                ),
                Container(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.people_outline,
                            color: Color(0xFF2E4053),
                            size: 30,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            widget.detail['role'],
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
  }

  void showDelete() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Delete data',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Apakah anda ingin menghapus data ini?',
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
              child: const Text(
                'Ya',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                await FirestoreMethod().deleteDataFromAdmin(
                  widget.detail['imageUrl'],
                  widget.detail['userid'],
                );
                Get.back();
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

  void editRole() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Role'),
          content: TextFormField(
            maxLength: 50,
            decoration: InputDecoration(
              labelText: 'Masukkan Role',
            ),
          ),
          actions: [
            ElevatedButton(
              child: Text('Batal'),
              onPressed: () {
                Get.back();
              },
            ),
            ElevatedButton(
              child: Text('Simpan'),
              onPressed: () async {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}
