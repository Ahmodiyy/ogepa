import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../actionButton.dart';
import '../../function.dart';
import '../../headerText.dart';
import '../../highkon.dart';
import '../../constant.dart';
import '../../richText.dart';
import '../login/login.dart';

class Register extends StatefulWidget {
  static String id = 'register';
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _obscureText = true;
  bool _obscureText2 = true;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  bool showSpinner = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TapGestureRecognizer _tapGestureRecognizer;
  late TapGestureRecognizer _tapGestureRecognizer2;
  late TapGestureRecognizer _tapGestureRecognizer3;
  late TapGestureRecognizer _tapGestureRecognizer4;

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer();
    _tapGestureRecognizer2 = TapGestureRecognizer();
    _tapGestureRecognizer3 = TapGestureRecognizer();
    _tapGestureRecognizer4 = TapGestureRecognizer();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _tapGestureRecognizer.dispose();
    _tapGestureRecognizer2.dispose();
    _tapGestureRecognizer3.dispose();
    _tapGestureRecognizer4.dispose();
    super.dispose();
  }

  void togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void togglePassword2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
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
                    headerTextString: 'Create an \naccount',
                  ),
                  constantLargerWhiteHorizontalSpacing,
                  TextFormField(
                    controller: _email,
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
                    controller: _password,
                    obscureText: _obscureText,
                    keyboardType: TextInputType.text,
                    decoration: constantTextFieldDecoration.copyWith(
                      hintText: 'Password',
                      prefixIcon: Highkon(
                        icondata: FontAwesomeIcons.lock,
                      ),
                      suffixIcon: InkWell(
                        onTap: togglePassword,
                        child: Icon(
                          _obscureText
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          size: 15.0,
                          color: constantActionColor,
                        ),
                      ),
                    ),
                    validator: (value) {
                      return validatePassword(value);
                    },
                  ),
                  constantSmallerHorizontalSpacing,
                  TextFormField(
                    controller: _confirmPassword,
                    obscureText: _obscureText2,
                    keyboardType: TextInputType.text,
                    decoration: constantTextFieldDecoration.copyWith(
                      hintText: 'Confirm password',
                      prefixIcon: Highkon(
                        icondata: FontAwesomeIcons.lock,
                      ),
                      suffixIcon: InkWell(
                        onTap: togglePassword2,
                        child: Icon(
                          _obscureText2
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          size: 15.0,
                          color: constantActionColor,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm password';
                      }
                      if (_password.text != _confirmPassword.text) {
                        return "Password does not match";
                      }
                      return null;
                    },
                  ),
                  constantSmallerHorizontalSpacing,
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'By clicking the ',
                        style: constantRichStyle,
                      ),
                      TextSpan(
                        recognizer: _tapGestureRecognizer..onTap = () {},
                        text: 'Sign Up ',
                        style: constantActionStyle,
                      ),
                      TextSpan(
                        text: 'button, ',
                        style: constantRichStyle,
                      ),
                      TextSpan(
                        text: 'you agree to our ',
                        style: constantRichStyle,
                      ),
                      TextSpan(
                        recognizer: _tapGestureRecognizer2..onTap = () {},
                        text: 'Terms & Condition ',
                        style: constantRichStyleUnderline,
                      ),
                      TextSpan(
                        text: 'and ',
                        style: constantRichStyle,
                      ),
                      TextSpan(
                        recognizer: _tapGestureRecognizer3..onTap = () {},
                        text: 'Privacy Policy.',
                        style: constantRichStyleUnderline,
                      ),
                    ]),
                  ),
                  constantSmallerHorizontalSpacing,
                  ActionButton(
                    dontHideActionText: showSpinner,
                    actionString: 'Sign up',
                    action: () async {
                      setState(() {
                        showSpinner = false;
                      });
                      if (_formKey.currentState!.validate()) {
                        // await Log().register(
                        //     context, _email.text.trim(), _password.text.trim());
                      }
                      setState(() {
                        showSpinner = true;
                      });
                    },
                  ),
                  constantSmallerHorizontalSpacing,
                  RichTexts(
                    suggestion: 'Already have an account? ',
                    suggestionAction: 'Sign in',
                    suggestionActionRoute: Login.id,
                    tapGestureRecognizer: _tapGestureRecognizer4,
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
