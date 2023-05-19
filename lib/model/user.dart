import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String userid;
  String uName;
  String email;
  String noTelp;
  String role;
  String createdAt;
  String imageUrl;

  User(
      {required this.userid,
      required this.uName,
      required this.email,
      required this.noTelp,
      required this.role,
      required this.createdAt,
      required this.imageUrl});

  static User fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      userid: snapshot['userid'],
      uName: snapshot['username'],
      email: snapshot['email'],
      noTelp: snapshot['noTelp'],
      role: snapshot['role'],
      createdAt: snapshot['createdAt'],
      imageUrl: snapshot['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "username": uName,
        "email": email,
        "noTelp": noTelp,
        "role": role,
        "createdAt": createdAt,
        "imageUrl": imageUrl,
      };
}
