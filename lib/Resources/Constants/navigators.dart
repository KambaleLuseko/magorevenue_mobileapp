import '../../main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Navigation {
  static pushNavigate({required Widget page, bool? isFullDialog = false}) {
    Navigator.push(
        navKey.currentContext!,
        CupertinoPageRoute(
            builder: (context) => page, fullscreenDialog: isFullDialog!));
  }

  static pushReplaceNavigate({required Widget page}) {
    Navigator.pushReplacement(
        navKey.currentContext!, CupertinoPageRoute(builder: (context) => page));
  }

  static pushRemove({required Widget page}) {
    // Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)
    Navigator.pushAndRemoveUntil(navKey.currentContext!,
        CupertinoPageRoute(builder: (context) => page), (route) => false);
  }
}
