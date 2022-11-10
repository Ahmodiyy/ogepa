import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogepa/presentation/login/login.dart';
import 'package:ogepa/presentation/onboarding/onboardingScreen.dart';
import 'package:ogepa/presentation/register/register.dart';
import 'package:ogepa/presentation/report/Report.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'constant.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool seen = (prefs.getBool('seen') ?? false);
  runApp(
    ProviderScope(
      child: MyApp(
        showHome: seen,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool showHome;
  const MyApp({super.key, required this.showHome});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ogepa',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      initialRoute: showHome ? Register.id : OnboardScreen.id,
      routes: {
        OnboardScreen.id: (context) => const OnboardScreen(),
        Register.id: (context) => const Register(),
        Login.id: (context) => const Login(),
        Report.id: (context) => const Report(),
      },
    );
  }
}
