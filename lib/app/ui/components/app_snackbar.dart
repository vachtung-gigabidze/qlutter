import 'package:flutter/material.dart';
import 'package:qlutter/app/domain/error_entity/error_entity.dart';

abstract class AppSnackBar {
  static void showSnackBarWithError(BuildContext context, ErrorEntity error) {
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(SnackBar(
        duration: const Duration(seconds: 5),
        content: SingleChildScrollView(
          child: Text(maxLines: 5, error.show()),
        )));
  }

  static void showSnackBarWithMessage(BuildContext context, String message) {
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(SnackBar(
        duration: const Duration(seconds: 5),
        content: SingleChildScrollView(
          child: Text(maxLines: 5, message),
        )));
  }

  static void clearSnackBar(BuildContext context) {
    ScaffoldMessenger.maybeOf(context)?.clearSnackBars();
  }
}
