import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:pengaduan_masyarakat_ver2/model/aduan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pengaduan_masyarakat_ver2/utils/delete_user_auth.dart';

class FirestoreMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;
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
  Future<void> updateData(
    String userid,
    String username,
    String email,
    String noTelp,
  ) async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      await _firestore.collection('users').doc(userid).update({
        "username": username,
        "email": email,
        "noTelp": noTelp,
      });
      await user!.updateEmail(email);
    } catch (e) {
      print(e);
    }
  }

  //update username for user
  Future<void> updateUsername(
    // String aduanid,
    String username,
  ) async {
    final snap = await _firestore
        .collection('aduan')
        .where('userid', isEqualTo: uid)
        .get();
    try {
      snap.docs.forEach((doc) {
        _firestore
            .collection('aduan')
            .doc(doc.id)
            .update({'username': username});
      });
    } catch (e) {
      print(e);
    }
  }

  //delete data aduan firestore
  Future<void> deleteData(String aduanid) async {
    final CollectionReference aduanRef = _firestore.collection('aduan');
    final CollectionReference riwayatRef =
        _firestore.collection('history_aduan');
    DocumentSnapshot aduanSnapshot = await aduanRef.doc(aduanid).get();

    try {
      if (aduanSnapshot.exists) {
        final aduanData = aduanSnapshot.data();

        await riwayatRef.doc(aduanid).set(aduanData);
        await aduanRef.doc(aduanid).delete();
      }

      // Reference ref = FirebaseStorage.instance.refFromURL(imageUrl);
      // ref.delete();
    } catch (e) {
      print(e);
    }
  }

  //delete data history aduan firestore storage
  Future<void> deleteDataHistory(String imageUrl, String aduanid) async {
    final CollectionReference historyRef =
        _firestore.collection('history_aduan');

    try {
      await historyRef.doc(aduanid).delete();

      Reference ref = FirebaseStorage.instance.refFromURL(imageUrl);
      ref.delete();
    } catch (e) {
      print(e);
    }
  }

  //admin verfication
  Future<void> addCheckProgess1(String aduanid, bool progress1) async {
    await _firestore
        .collection("aduan")
        .doc(aduanid)
        .update({'progress1': progress1});
  }

  Future<void> addCheckProgess2(String aduanid, bool progress2) async {
    await _firestore
        .collection("aduan")
        .doc(aduanid)
        .update({'progress2': progress2});
  }

  Future<void> addCheckProgess3(String aduanid, bool progress3) async {
    await _firestore
        .collection("aduan")
        .doc(aduanid)
        .update({'progress3': progress3});
  }

  //admin edit user
  Future<void> updateRoleFromAdmin(
    String userid,
    String role,
  ) async {
    try {
      await _firestore.collection('users').doc(userid).update({
        "role": role,
      });
    } catch (e) {
      print(e);
    }
  }

  //admin delete user
  Future<void> deleteDataFromAdmin(String imageUrl, String userid) async {
    try {
      _firestore.collection('users').doc(userid).delete();
      Reference ref = FirebaseStorage.instance.refFromURL(imageUrl);
      ref.delete();
    } catch (e) {
      print(e);
    }
  }
}
