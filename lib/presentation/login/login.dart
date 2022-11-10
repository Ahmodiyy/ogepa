import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ogepa/data/login/loginRepo.dart';

import '../../actionButton.dart';
import '../../function.dart';
import '../../headerText.dart';
import '../../highkon.dart';
import '../../constant.dart';
import '../../richText.dart';
import '../register/register.dart';
import '../report/Report.dart';
import 'loginController.dart';

final loginControllerProvider =
    StateNotifierProvider<LoginController, AsyncValue<void>>((ref) {
  return LoginController();
});

class Login extends ConsumerStatefulWidget {
  static String id = 'login';
  const Login({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  bool _obscureText = true;
  bool showSpinner = true;
  late TapGestureRecognizer _tapGestureRecognizerForgotPassword;
  late TapGestureRecognizer _tapGestureRecognizerSignIn;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _email;
  late TextEditingController _password;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
    _tapGestureRecognizerForgotPassword = TapGestureRecognizer();
    _tapGestureRecognizerSignIn = TapGestureRecognizer();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _tapGestureRecognizerForgotPassword.dispose();
    _tapGestureRecognizerSignIn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      loginControllerProvider,
      (_, state) => state.whenOrNull(
        error: (error, stackTrace) {
          // show snackbar if an error occurred
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          );
        },
      ),
    );
    final loginValue = ref.watch(loginControllerProvider);
    final isLoading = loginValue is AsyncLoading<void>;
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
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: constantTextFieldDecoration.copyWith(
                      hintText: 'Email Address',
                      prefixIcon: const Highkon(
                        icondata: FontAwesomeIcons.user,
                      ),
                    ),
                    validator: (value) {
                      return validateEmail(value);
                    },
                  ),
                  constantSmallerHorizontalSpacing,
                  TextFormField(
                    controller: _password,
                    obscureText: _obscureText,
                    keyboardType: TextInputType.text,
                    decoration: constantTextFieldDecoration.copyWith(
                      hintText: 'Password',
                      prefixIcon: const Highkon(
                        icondata: FontAwesomeIcons.lock,
                      ),
                      suffixIcon: InkWell(
                        onTap: _toggle,
                        child: Icon(
                          _obscureText
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          size: 15.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      return validatePassword(value);
                    },
                  ),
                  constantLargerWhiteHorizontalSpacing,
                  ActionButton(
                    action: () async {
                      if (_formKey.currentState!.validate()) {
                        ref.read(loginControllerProvider.notifier).login(
                            context, _email.text.trim(), _password.text.trim());
                      }
                    },
                    actionString: 'Sign in',
                    isLoading: isLoading,
                  ),
                  constantSmallerHorizontalSpacing,
                  RichTexts(
                    suggestion: 'Don\'t have an account? ',
                    suggestionAction: 'Sign up',
                    suggestionActionRoute: Register.id,
                    tapGestureRecognizer: _tapGestureRecognizerSignIn,
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
