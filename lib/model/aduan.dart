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

  Aduan(
      {required this.aduanid,
      required this.judul,
      required this.deskripsi,
      required this.imageUrl,
      required this.lokasi,
      required this.uName,
      required this.datePublished,
      required this.userid});

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
    );
  }

  Map<String, dynamic> toJson() => {
        "aduanid": aduanid,
        "judul": judul,
        "deskripsi": deskripsi,
        "imageUrl": imageUrl,
        "lokasi": lokasi,
        "username": uName,
        "datePublished": datePublished,
        "userid": userid
      };
}
