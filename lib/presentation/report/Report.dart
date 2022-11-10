import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../actionButton.dart';
import '../../function.dart';
import '../../headerText.dart';
import '../../constant.dart';
import 'ReportController.dart';

final selectImageProvider = StateProvider<bool>((ref) {
  return false;
});
final reportControllerProvider =
    StateNotifierProvider<ReportController, AsyncValue<void>>((ref) {
  return ReportController();
});

class Report extends ConsumerStatefulWidget {
  static String id = 'Report';
  const Report({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _ReportState();
}

class _ReportState extends ConsumerState<Report> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _title;
  late TextEditingController _description;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController();
    _description = TextEditingController();
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      reportControllerProvider,
      (_, state) => state.whenOrNull(
        error: (error, stackTrace) {
          // show snackbar if an error occurred
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          );
        },
      ),
    );
    final reportValue = ref.watch(reportControllerProvider);
    final selectImage = ref.watch(selectImageProvider);
    final isLoading = reportValue is AsyncLoading<void>;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  constantLargerWhiteHorizontalSpacing,
                  HeaderText(
                    headerTextString: 'Report\nenvironment violation!',
                  ),
                  constantLargerWhiteHorizontalSpacing,
                  TextFormField(
                    controller: _title,
                    keyboardType: TextInputType.text,
                    decoration: constantTextFieldDecoration.copyWith(
                      hintText: 'Title',
                    ),
                    validator: (value) {
                      return validateEmail(value);
                    },
                  ),
                  constantSmallerHorizontalSpacing,
                  TextFormField(
                    controller: _description,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    decoration: constantTextFieldDecoration.copyWith(
                      hintText: 'Description',
                    ),
                    validator: (value) {
                      return validateEmail(value);
                    },
                  ),
                  constantSmallerHorizontalSpacing,
                  Text('Select image'),
                  constantSmallerHorizontalSpacing,
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    height: 150,
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.upload,
                      ),
                      onPressed: () async {
                        try {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles();
                          print('file name is ${result?.files.first.name}');
                          if (result != null) {
                            File file = File(result.files.first.path!);
                            String? fileName = result.files.first.name;
                            await FirebaseStorage.instance
                                .ref('picture/$fileName')
                                .putFile(file);
                          } else {
                            print('User canceled the picker');
                          }
                        } catch (e) {
                          print(e.toString());
                        }
                      },
                    ),
                  ),
                  constantLargerWhiteHorizontalSpacing,
                  ActionButton(
                    action: () async {
                      if (_formKey.currentState!.validate()) {
                        // ref
                        //     .read(reportControllerProvider.notifier)
                        //     .login(_title.text.trim(), _description.text.trim())
                        //     .then((value) => value?.user != null
                        //         ? Navigator.pushNamed(context, Report.id)
                        //         : null);
                      }
                    },
                    actionString: 'Report',
                    isLoading: isLoading,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
