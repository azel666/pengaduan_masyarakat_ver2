import 'package:pengaduan_masyarakat_ver2/model/aduan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> addAduan(
      String judul,
      String deskripsi,
      String lokasi,
      String username,
      String imageUrl,
      String datePublished,
      String userid) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
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
          userid: userid);
      _firestore.collection('aduan').doc(doc.id).set(aduan.toJson());
      res = "Success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
