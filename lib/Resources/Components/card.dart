import 'package:flutter/material.dart';

import '../../Resources/Components/texts.dart';
import '../../Resources/Constants/global_variables.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final Widget content;
  double? elevation = 0;
  Color? backColor = AppColors.kScaffoldColor;
  Color? titleColor = AppColors.kBlackColor;

  CardWidget(
      {Key? key,
      required this.title,
      this.elevation,
      required this.content,
      this.backColor,
      this.titleColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      color: backColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      // elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Column(
        children: [
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: AppColors.kWhiteColor.withOpacity(0.6),
                borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: TextWidgets.textBold(
                  title: title,
                  fontSize: 18,
                  textColor: titleColor ?? AppColors.kBlackColor),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: EdgeInsets.only(
                left: kDefaultPadding,
                top: kDefaultPadding / 2,
                right: kDefaultPadding / 2,
                bottom: kDefaultPadding / 2),
            width: double.maxFinite,
            child: content,
          ),
        ],
      ),
    );
  }
}
