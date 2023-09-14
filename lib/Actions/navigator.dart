import 'package:flutter/material.dart';

Future<dynamic> goToNextPage(
    {required BuildContext context, required Widget page}) async {
  return await Navigator.push(
      context, MaterialPageRoute(builder: (context) => page));
}

goOnlyNextPage({required BuildContext context, required Widget page}) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => page),
      (Route<dynamic> route) => false);
}
