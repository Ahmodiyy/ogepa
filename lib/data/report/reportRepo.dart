import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ReportRepo {
  final FirebaseFirestore _cloudStore = FirebaseFirestore.instance;

  Future<void> report(BuildContext context, String? userEmail, String name,
      String userName, String profession, String profileUrl, String bio) async {
    await _cloudStore.collection('User Data').add({
      'User Email': userEmail,
      'Name': name,
      'Username': userName,
      'Profession': profession,
      'Profile URL': profileUrl,
      'Bio': bio,
      'Time': FieldValue.serverTimestamp(),
    });
  }
}
