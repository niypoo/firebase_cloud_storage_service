import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class FirebaseStorageHelper {
  static FirebaseStorage storage = FirebaseStorage.instance;

  // get download url link for image
  static Future<String> getDownloadLink({
    required String path,
    required String filename,
  }) async {
    // recreance with path and file name
    final Reference ref = storage.ref().child(path).child(filename);

    // get path url
    return await ref.getDownloadURL();
  }

  // get download url link for image
  static Future<String> getDownloadLinkFromSnapshot(
          TaskSnapshot snapshot) async =>
      await snapshot.ref.getDownloadURL();

  // upload
  static Future<TaskSnapshot?> upload({
    String? path,
    String? filename,
    File? file,
  }) async {
    // check file not null

    if (file == null) return null;

    UploadTask uploadTask;

    // Create a Reference to the file
    Reference ref =
        FirebaseStorage.instance.ref().child(path!).child('/$filename');

    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes());
    } else {
      uploadTask = ref.putFile(File(file.path));
    }

    return await Future.value(uploadTask);
  }

  // delete
  static Future<void> deleteFromUrl({
    String? url,
  }) async {
    // check file not null
    if (url == null || url.isEmpty) return;
    // Create a Reference to the file
    Reference ref = FirebaseStorage.instance.refFromURL(url);

    await ref.delete();
  }

  // delete
  static Future<void> delete({
    required String path,
    required String filename,
  }) async {
    // recreance with path and file name
    final Reference ref = storage.ref().child(path).child(filename);

    // delete
    return await ref.delete();
  }
}
