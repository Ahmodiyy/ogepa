import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ReportRepo {
  final FirebaseFirestore _cloudStore = FirebaseFirestore.instance;

  Future<DocumentReference<Map<String, dynamic>>> report(
      {required String userEmail,
      required String title,
      required String description,
      required String reportPictureUrl}) async {
    return await _cloudStore.collection('report').add({
      'user email': userEmail,
      'title': title,
      'description': description,
      'report picture': reportPictureUrl,
      'Time': FieldValue.serverTimestamp(),
    });
  }

  Future<TaskSnapshot> uploadReportPicture(
      {required String fileName, required File file}) async {
    return await FirebaseStorage.instance
        .ref('picture/$fileName')
        .putFile(file);
  }
}
