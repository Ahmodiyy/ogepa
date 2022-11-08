import 'package:flutter/material.dart';

class Highkon extends StatelessWidget {
  final IconData icondata;
  const Highkon({required this.icondata});

  @override
  Widget build(BuildContext context) {
    return Icon(
      icondata,
      size: 15.0,
      color: const Color(0xff087D04),
    );
  }
}
