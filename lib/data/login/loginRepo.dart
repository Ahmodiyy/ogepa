import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../function.dart';
import '../../presentation/report/Report.dart';

class LoginRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> getUser() async {
    return _firebaseAuth.currentUser;
  }

  login(String email, String password) {
    _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
