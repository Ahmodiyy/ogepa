import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ogepa/presentation/register/registerController.dart';

import '../../actionButton.dart';
import '../../function.dart';
import '../../headerText.dart';
import '../../highkon.dart';
import '../../constant.dart';
import '../../richText.dart';
import '../login/login.dart';

final registerControllerProvider =
    StateNotifierProvider<RegisterController, AsyncValue<void>>((ref) {
  return RegisterController();
});

class Register extends ConsumerStatefulWidget {
  static String id = 'register';
  const Register({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _RegisterState();
}

class _RegisterState extends ConsumerState<Register> {
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
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
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
    ref.listen<AsyncValue<void>>(
      registerControllerProvider,
      (_, state) => state.whenOrNull(
        error: (error, stackTrace) {
          // show snackbar if an error occurred
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          );
        },
      ),
    );
    final registerValue = ref.watch(registerControllerProvider);
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
                    headerTextString: 'Create an \naccount',
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
                      prefixIcon: const Highkon(
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
                      const TextSpan(
                        text: 'By clicking the ',
                        style: constantRichStyle,
                      ),
                      TextSpan(
                        recognizer: _tapGestureRecognizer..onTap = () {},
                        text: 'Sign Up ',
                        style: constantActionStyle,
                      ),
                      const TextSpan(
                        text: 'button, ',
                        style: constantRichStyle,
                      ),
                      const TextSpan(
                        text: 'you agree to our ',
                        style: constantRichStyle,
                      ),
                      TextSpan(
                        recognizer: _tapGestureRecognizer2..onTap = () {},
                        text: 'Terms & Condition ',
                        style: constantRichStyleUnderline,
                      ),
                      const TextSpan(
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
                    isLoading: isLoading,
                    actionString: 'Sign up',
                    action: () async {
                      if (_formKey.currentState!.validate()) {
                        ref
                            .read(registerControllerProvider.notifier)
                            .register(_email.text.trim(), _password.text.trim())
                            .then((value) => value?.user != null
                                ? Navigator.pushNamed(context, Login.id)
                                : null);
                      }
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
