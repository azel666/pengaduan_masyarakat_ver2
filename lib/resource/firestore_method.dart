import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:pengaduan_masyarakat_ver2/model/aduan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //add data aduan ke firestore
  Future<String> addAduan(
      String judul,
      String deskripsi,
      String lokasi,
      String username,
      String imageUrl,
      String datePublished,
      String userid) async {
    String res = "Some error occurred";
    try {
      final col = _firestore.collection('aduan');
      final doc = col.doc();
      Aduan aduan = Aduan(
        aduanid: doc.id,
        judul: judul,
        deskripsi: deskripsi,
        imageUrl: imageUrl,
        lokasi: lokasi,
        uName: username,
        datePublished: datePublished,
        userid: userid,
        progress1: false,
        progress2: false,
        progress3: false,
      );
      _firestore.collection('aduan').doc(doc.id).set(aduan.toJson());
      res = "Success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //update user
  Future<void> updateUser(
    String userid,
    String username,
    String email,
    String noTelp,
  ) async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      await FirebaseFirestore.instance.collection('users').doc(userid).update({
        "username": username,
        "email": email,
        "noTelp": noTelp,
      });
      await user!.updateEmail(email);
    } catch (e) {
      print(e);
    }
  }

  //delete data aduan firestore storage
  Future<void> deleteData(String imageUrl, String aduanid) async {
    try {
      FirebaseFirestore.instance.collection('aduan').doc(aduanid).delete();
      Reference ref = FirebaseStorage.instance.refFromURL(imageUrl);
      ref.delete();
    } catch (e) {
      print(e);
    }
  }

  //admin verfication
  Future<void> addCheckProgess1(String aduanid, bool progress1) async {
    await FirebaseFirestore.instance
        .collection("aduan")
        .doc(aduanid)
        .update({'progress1': progress1});
  }

  Future<void> addCheckProgess2(String aduanid, bool progress2) async {
    await FirebaseFirestore.instance
        .collection("aduan")
        .doc(aduanid)
        .update({'progress2': progress2});
  }

  Future<void> addCheckProgess3(String aduanid, bool progress3) async {
    await FirebaseFirestore.instance
        .collection("aduan")
        .doc(aduanid)
        .update({'progress3': progress3});
  }
}
