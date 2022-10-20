import 'package:flutter/material.dart';

import '../../Resources/Constants/global_variables.dart';

class DecoratedContainer extends StatelessWidget {
  Color? backColor;
  final Widget child;

  DecoratedContainer(
      {Key? key, this.backColor = Colors.grey, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultPadding / 2),
        color: backColor!.withOpacity(0.3),
      ),
      child: child,
    );
  }
}
