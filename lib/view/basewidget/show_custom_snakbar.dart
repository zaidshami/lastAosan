import 'package:flutter/material.dart';
import '../../../../utill/color_resources.dart';

void showCustomSnackBar(String message, BuildContext context, {bool isError = true}) {
  //chng snackbar
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: isError ? ColorResources.getRed(context) : Colors.green,
    content: Text(message),
  ));
}
