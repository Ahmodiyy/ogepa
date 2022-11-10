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
      maxLines: 2,
      style: const TextStyle(
        fontSize: 30,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
