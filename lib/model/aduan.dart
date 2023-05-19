import 'package:cloud_firestore/cloud_firestore.dart';

class Aduan {
  String aduanid;
  String judul;
  String deskripsi;
  String imageUrl;
  String lokasi;
  String uName;
  String datePublished;
  String userid;
  bool progress1;
  bool progress2;
  bool progress3;

  Aduan({
    required this.aduanid,
    required this.judul,
    required this.deskripsi,
    required this.imageUrl,
    required this.lokasi,
    required this.uName,
    required this.datePublished,
    required this.userid,
    required this.progress1,
    required this.progress2,
    required this.progress3,
  });

  static Aduan fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Aduan(
        aduanid: snapshot['aduanid'],
        judul: snapshot['judul'],
        deskripsi: snapshot['deskripsi'],
        imageUrl: snapshot['imageUrl'],
        lokasi: snapshot['lokasi'],
        uName: snapshot['username'],
        datePublished: snapshot['datePublished'],
        userid: snapshot['userid'],
        progress1: snapshot['progress1'],
        progress2: snapshot['progress2'],
        progress3: snapshot['progress3']);
  }

  Map<String, dynamic> toJson() => {
        "aduanid": aduanid,
        "judul": judul,
        "deskripsi": deskripsi,
        "imageUrl": imageUrl,
        "lokasi": lokasi,
        "username": uName,
        "datePublished": datePublished,
        "userid": userid,
        "progress1": progress1,
        "progress2": progress2,
        "progress3": progress3,
      };
}
