import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String actionString;
  final Function action;
  final bool isLoading;

  ActionButton({
    required this.actionString,
    required this.action,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.all(
            20,
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          const Color(0xff087D04),
        ),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        )),
      ),
      onPressed: () async {
        await action();
      },
      child: Visibility(
        visible: isLoading,
        replacement: Text(
          actionString,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        child: const CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
