import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Homepage extends ConsumerWidget {
  static String id = 'homepage';
  const Homepage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Row(
            children: [
              buildCard(FontAwesomeIcons.eye, 'text', 'navigation'),
              buildCard(FontAwesomeIcons.eye, 'text', 'navigation'),
            ],
          )),
          Expanded(
              child: Row(
            children: [
              buildCard(FontAwesomeIcons.eye, 'text', 'navigation'),
              buildCard(FontAwesomeIcons.eye, 'text', 'navigation'),
            ],
          )),
        ],
      ),
    ));
  }

  Widget buildCard(IconData iconData, String text, String navigation) {
    return Card(
      color: Colors.green,
      child: Column(
        children: [
          Icon(iconData),
          Text(text),
        ],
      ),
    );
  }
}
