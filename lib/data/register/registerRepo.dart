import 'package:firebase_auth/firebase_auth.dart';

class RegisterRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> register(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
