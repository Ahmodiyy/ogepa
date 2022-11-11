import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:file_picker/file_picker.dart';

import '../../actionButton.dart';
import '../../function.dart';
import '../../headerText.dart';
import '../../constant.dart';
import 'ReportController.dart';

final selectImageProvider = StateProvider<bool>((ref) => false);
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
  File? file;
  String? fileName;

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
    ref.listen<AsyncValue<void>>(
      reportControllerProvider,
      (_, state) => state.whenOrNull(
        data: (data) => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Thanks! Your report has been logged')),
        ),
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
                      return validate(value);
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
                      return validate(value);
                    },
                  ),
                  constantSmallerHorizontalSpacing,
                  const Text('Select image'),
                  constantSmallerHorizontalSpacing,
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    height: 150,
                    child: selectImage
                        ? Stack(
                            children: [
                              Image.file(
                                file!,
                                width: double.infinity,
                              ),
                              Center(
                                child: IconButton(
                                    onPressed: () {
                                      file = null;
                                      ref
                                          .read(selectImageProvider.notifier)
                                          .update((state) => !state);
                                    },
                                    icon: const Icon(
                                        FontAwesomeIcons.circleXmark)),
                              )
                            ],
                          )
                        : IconButton(
                            icon: const Icon(
                              FontAwesomeIcons.upload,
                            ),
                            onPressed: () async {
                              try {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles();
                                print(
                                    'file name is ${result?.files.first.name}');

                                if (result != null) {
                                  file = File(result.files.first.path!);
                                  fileName = result.files.first.name;
                                  ref
                                      .read(selectImageProvider.notifier)
                                      .update((state) => !state);
                                } else {
                                  print('User canceled the picker');
                                }
                              } catch (e) {
                                print('eroooooooooooooooor1 ${e.toString()}');
                              }
                            },
                          ),
                  ),
                  constantLargerWhiteHorizontalSpacing,
                  ActionButton(
                    action: () async {
                      if (_formKey.currentState!.validate()) {
                        if (file == null && fileName == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Select an image to continue')),
                          );
                          return;
                        }
                        ref
                            .read(reportControllerProvider.notifier)
                            .report(
                              title: _title.text,
                              file: file!,
                              fileName: fileName!,
                              description: _description.text,
                            )
                            .then((value) {
                          if (value != null) {
                            _title.clear();
                            _description.clear();
                            fileName = null;
                            file = null;
                            ref
                                .read(selectImageProvider.notifier)
                                .update((state) => !state);
                          }
                        }, onError: (e) {
                          print('eroooooooooooooooooor2 $e');
                        });
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
