import 'dart:io';
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
      ;
    }
  }
}
