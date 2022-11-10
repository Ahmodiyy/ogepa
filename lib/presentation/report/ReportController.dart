import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/login/loginRepo.dart';

class ReportController extends StateNotifier<AsyncValue<void>> {
  ReportController() : super(const AsyncValue.data(null));

  Future<UserCredential?> login(String email, String password) async {
    UserCredential? userCredential;
    try {
      // set state to `loading` before starting the asynchronous work
      state = const AsyncValue.loading();
      // do the async work
      userCredential = await LoginRepo().login(email, password);
    } catch (e) {
      // if the payment failed, set the error state
      state = AsyncValue.error(e.toString(), StackTrace.current);
    } finally {
      // set state to `data(null)` at the end (both for success and failure)
      state = AsyncValue.data(userCredential);
    }
    return userCredential;
  }
}
