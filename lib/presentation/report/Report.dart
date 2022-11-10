import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../actionButton.dart';
import '../../function.dart';
import '../../headerText.dart';
import '../../highkon.dart';
import '../../constant.dart';
import '../../richText.dart';
import '../register/register.dart';
import 'ReportController.dart';

final reportControllerProvider =
    StateNotifierProvider<ReportController, AsyncValue<void>>((ref) {
  return ReportController();
});

class Report extends ConsumerStatefulWidget {
  static String id = 'login';
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
    final registerValue = ref.watch(reportControllerProvider);
    final isLoading = registerValue is AsyncLoading<void>;
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
                    headerTextString: 'Welcome\nback!',
                  ),
                  constantLargerWhiteHorizontalSpacing,
                  TextFormField(
                    controller: _title,
                    keyboardType: TextInputType.text,
                    decoration: constantTextFieldDecoration.copyWith(
                      hintText: 'Title',
                      prefixIcon: const Highkon(
                        icondata: FontAwesomeIcons.user,
                      ),
                    ),
                    validator: (value) {
                      return validateEmail(value);
                    },
                  ),
                  constantSmallerHorizontalSpacing,
                  constantLargerWhiteHorizontalSpacing,
                  ActionButton(
                    action: () async {
                      if (_formKey.currentState!.validate()) {
                        ref
                            .read(reportControllerProvider.notifier)
                            .login(_title.text.trim(), _description.text.trim())
                            .then((value) => value?.user != null
                                ? Navigator.pushNamed(context, Report.id)
                                : null);
                      }
                    },
                    actionString: 'Sign in',
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
