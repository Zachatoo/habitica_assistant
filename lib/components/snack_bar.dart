import 'package:flutter/material.dart';

enum snackBarDuration {
  short,
  long,
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> buildSnackBar({
  required BuildContext context,
  required String content,
  SnackBarAction? action,
  snackBarDuration? duration,
}) {
  late Duration _duration;
  switch (duration) {
    case snackBarDuration.short:
      _duration = const Duration(milliseconds: 1500);
      break;
    case snackBarDuration.long:
    default:
      _duration = const Duration(seconds: 3);
      break;
  }
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
      action: action,
      duration: _duration,
      width: 330,
    ),
  );
}
