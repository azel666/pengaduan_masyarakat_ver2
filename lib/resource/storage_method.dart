import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageMethod {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> uploadImageToStorage(String imgUrl, XFile image) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceRoot = _storage.ref();
    Reference referenceDir = referenceRoot.child('aduan');
    Reference referenceImageUpload = referenceDir.child(fileName);

    try {
      await referenceImageUpload.putFile(File(image.path));
      imgUrl = await referenceImageUpload.getDownloadURL();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  //update foto
  void updateProfilePhoto(File newImage, String previousImageUrl) async {
    User? user = FirebaseAuth.instance.currentUser;

    //delete previous foto
    deletePreviousPhoto(previousImageUrl);

    // Unggah foto ke Firebase Storage
    final storageRef = await FirebaseStorage.instance
        .ref()
        .child('profile_photos/${user!.uid}.jpg');
    await storageRef.putFile(newImage);

    // Dapatkan URL foto yang diunggah
    final imageUrl = await storageRef.getDownloadURL();

    // Perbarui URL foto di Firestore
    FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'imageUrl': imageUrl,
    });
  }

  //delete update previous foto
  void deletePreviousPhoto(String previousImageUrl) async {
    if (previousImageUrl.isNotEmpty) {
      final storageRef = FirebaseStorage.instance.refFromURL(previousImageUrl);
      await storageRef.delete();
    }
  }
}
