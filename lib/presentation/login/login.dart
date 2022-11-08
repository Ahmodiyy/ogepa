import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../actionButton.dart';
import '../../function.dart';
import '../../headerText.dart';
import '../../highkon.dart';
import '../../constant.dart';
import '../../richText.dart';
import '../register/register.dart';

class Login extends StatefulWidget {
  static String id = 'login';
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  bool showSpinner = true;
  late TapGestureRecognizer _tapGestureRecognizerForgotPassword;
  late TapGestureRecognizer _tapGestureRecognizerSignIn;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizerForgotPassword = TapGestureRecognizer();
    _tapGestureRecognizerSignIn = TapGestureRecognizer();
  }

  @override
  void dispose() {
    _tapGestureRecognizerForgotPassword.dispose();
    _tapGestureRecognizerSignIn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: constantTextFieldDecoration.copyWith(
                      hintText: 'Email Address',
                      prefixIcon: Highkon(
                        icondata: FontAwesomeIcons.user,
                      ),
                    ),
                    validator: (value) {
                      return validateEmail(value);
                    },
                  ),
                  constantSmallerHorizontalSpacing,
                  TextFormField(
                    controller: password,
                    obscureText: _obscureText,
                    keyboardType: TextInputType.text,
                    decoration: constantTextFieldDecoration.copyWith(
                      hintText: 'Password',
                      prefixIcon: Highkon(
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
                      setState(() {
                        showSpinner = false;
                      });
                      if (_formKey.currentState!.validate()) {
                        try {
                          // await Log().login(
                          //   context,
                          //   email.text.trim(),
                          //   password.text.trim(),
                          // );
                        } catch (e) {
                          showErrorMsg(context, e.toString());
                        }
                      }
                      setState(() {
                        showSpinner = true;
                      });
                    },
                    actionString: 'Sign in',
                    dontHideActionText: showSpinner,
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
