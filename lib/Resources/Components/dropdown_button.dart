import 'package:flutter/material.dart';

import '../../Resources/Constants/global_variables.dart';

class CustomDropdownButton extends StatelessWidget {
  final String hintText;
  String? value;
  final List<String> items;
  Function callBack;
  Color? textColor = AppColors.kWhiteColor.withOpacity(0.7);
  Color? dropdownColor = AppColors.kBlackLightColor;
  Color? backColor = AppColors.kTextFormWhiteColor;
  bool? displayLabel;
  CustomDropdownButton(
      {Key? key,
      required this.value,
      required this.hintText,
      required this.callBack,
      this.textColor,
      this.dropdownColor,
      this.backColor,
      required this.items,
      this.displayLabel = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (displayLabel == true)
            Text(
              hintText,
              style: TextStyle(color: textColor),
            ),
          const SizedBox(
            height: 0,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: backColor,
                borderRadius: BorderRadius.circular(kDefaultPadding / 4)),
            child: DropdownButton(
              underline: Container(),
              dropdownColor: dropdownColor,
              isExpanded: true,
              items: items.map((element) {
                return DropdownMenuItem(
                  child: Text(
                    element,
                    style: TextStyle(color: textColor),
                  ),
                  value: element,
                );
              }).toList(),
              onChanged: (value) {
                callBack(value);
              },
              value: value,
            ),
          ),
        ],
      ),
    );
  }
}
