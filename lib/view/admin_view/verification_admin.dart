import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pengaduan_masyarakat_ver2/resource/firestore_method.dart';
import 'package:pengaduan_masyarakat_ver2/shared/my_color.dart';

class VerificationAdmin extends StatefulWidget {
  final detail;
  const VerificationAdmin({required this.detail, super.key});

  @override
  State<VerificationAdmin> createState() => _VerificationAdminState();
}

class _VerificationAdminState extends State<VerificationAdmin> {
  bool progress1 = false;
  bool progress2 = false;
  bool progress3 = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataProgress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: const Text(
            'Detail Aduan',
            style: TextStyle(
              color: Color(0xFF2E4053),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          // backgroundColor: "#8E44AD".toColor(),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Color(0xFF2E4053)),
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints.tightFor(
              height: 1000,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.only(
                  top: 15, right: 15, left: 15, bottom: 15),
              // color: "#5B2C6F".toColor(),
              color: Colors.white,
              child: content(),
            ),
          ),
        ));
  }

  Widget content() {
    return PhysicalModel(
      borderRadius: BorderRadius.circular(10),
      elevation: 3,
      color: "#EAECEE".toColor(),
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 5, 5, 20),
        width: MediaQuery.of(context).size.width,
        height: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              Image.network(widget.detail['imageUrl']).image)),
                ),
                Container(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    widget.detail['judul'],
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    widget.detail['deskripsi'],
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                  ),
                ),
                Container(
                  // margin: EdgeInsets.only(top: 40),
                  // padding: EdgeInsets.only(top: 50),
                  child: Text(
                    "Lokasi : ${widget.detail['lokasi']}",
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                  ),
                ),
                Container(
                  child: Text(
                    "Pelapor : ${widget.detail['username']}",
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 2,
              color: Colors.black38,
              indent: 5,
              endIndent: 5,
            ),
            PhysicalModel(
              color: Color(0xFF2E4053),
              borderRadius: BorderRadius.circular(20),
              elevation: 3,
              child: Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Text(
                        'Verifikasi',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              child: Checkbox(
                                activeColor: Colors.green,
                                value: progress1,
                                onChanged: (bool? value) {
                                  setState(() {
                                    progress1 = value!;
                                  });
                                  FirestoreMethod().addCheckProgess1(
                                      widget.detail['aduanid'], progress1);
                                },
                              ),
                            ),
                            const SizedBox(
                              child: Text(
                                'Verifikasi aduan',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              child: Checkbox(
                                  activeColor: Colors.green,
                                  value: progress2,
                                  onChanged: progress1
                                      ? (bool? value) {
                                          setState(() {
                                            progress2 = value!;
                                          });
                                          FirestoreMethod().addCheckProgess2(
                                              widget.detail['aduanid'],
                                              progress2);
                                        }
                                      : null),
                            ),
                            SizedBox(
                              child: Text(
                                'Masalah sedang diproses',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                    color: progress1 != false
                                        ? Colors.white
                                        : Colors.grey),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              child: Checkbox(
                                  activeColor: Colors.green,
                                  value: progress3,
                                  onChanged: progress1 && progress2
                                      ? (bool? value) {
                                          setState(() {
                                            progress3 = value!;
                                          });
                                          FirestoreMethod().addCheckProgess3(
                                              widget.detail['aduanid'],
                                              progress3);
                                        }
                                      : null),
                            ),
                            SizedBox(
                              child: Text(
                                'Masalah terselsaikan',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: progress1 && progress2 != false
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future dataProgress() async {
    await FirebaseFirestore.instance
        .collection('aduan')
        .doc(widget.detail['aduanid'])
        .get()
        .then((snap) {
      if (snap.exists) {
        setState(() {
          progress1 = snap.get('progress1');
          progress2 = snap.get('progress2');
          progress3 = snap.get('progress3');
        });
      }
    });
  }
}
