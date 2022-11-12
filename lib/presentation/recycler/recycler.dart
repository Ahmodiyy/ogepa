import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Recycler extends ConsumerWidget {
  static String id = 'recycle';
  const Recycler({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(child: Scaffold());
  }
}
