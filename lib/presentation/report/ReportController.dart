import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogepa/data/login/loginRepo.dart';
import 'package:ogepa/data/report/reportRepo.dart';

class ReportController extends StateNotifier<AsyncValue<void>> {
  ReportController() : super(const AsyncValue.data(null));

  Future<DocumentReference<Map<String, dynamic>>?> report(
      {required String fileName,
      required File file,
      required String title,
      required String description}) async {
    DocumentReference<Map<String, dynamic>>? documentReference;
    TaskSnapshot taskSnapshot;
    try {
      // set state to `loading` before starting the asynchronous work
      state = const AsyncValue.loading();
      // do the async work
      taskSnapshot = await ReportRepo()
          .uploadReportPicture(fileName: fileName, file: file);
      documentReference = await ReportRepo().report(
        title: title,
        description: description,
        userEmail: LoginRepo().getUser()!.email!,
        reportPictureUrl: await taskSnapshot.ref.getDownloadURL(),
      );
    } catch (e) {
      // if the payment failed, set the error state
      state = AsyncValue.error(e.toString(), StackTrace.current);
    } finally {
      // set state to `data(null)` at the end (both for success and failure)
      state = const AsyncValue.data(null);
    }
    return documentReference;
  }
}
