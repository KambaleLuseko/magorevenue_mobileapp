import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile, web, tablet;
  const Responsive(
      {Key? key, required this.mobile, required this.tablet, required this.web})
      : super(key: key);
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 650 &&
      MediaQuery.of(context).size.width < 1100;

  static bool isWeb(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 1100) {
        // print('isWeb');
        // print('${constraints.maxHeight}');
        return web;
      } else if (constraints.maxWidth >= 650 && constraints.maxWidth < 1100) {
        // print('isTablet');
        // print('${constraints.maxHeight}');
        return tablet;
      } else {
        // print('isMobile');
        // print('${constraints.maxHeight}');
        return mobile;
      }
    });
  }
}
