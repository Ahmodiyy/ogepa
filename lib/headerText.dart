import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  final String headerTextString;
  HeaderText({
    required this.headerTextString,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      headerTextString,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
