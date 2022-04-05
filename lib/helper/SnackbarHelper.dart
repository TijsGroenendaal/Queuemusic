import 'package:flutter/material.dart';

class SnackbarHelper {

  static void deploy(Text msg, BuildContext context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    final snackbar = SnackBar(
      content: msg,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}