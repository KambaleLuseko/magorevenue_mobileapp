import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Resources/Constants/global_variables.dart';

class SearchTextFormFieldWidget extends StatefulWidget {
  final String hintText;
  final Color textColor;
  final Color backColor;
  final bool? isEnabled;
  final bool? isObsCured;
  final TextEditingController editCtrller;
  TextInputType inputType = TextInputType.text;
  int maxLines = 1;
  int? maxLength;
  SearchTextFormFieldWidget(
      {Key? key,
      required this.hintText,
      required this.textColor,
      required this.backColor,
      required this.editCtrller,
      TextInputType? inputType,
      this.maxLength,
      this.isEnabled,
      this.isObsCured,
      required this.maxLines})
      : super(key: key);

  @override
  _SearchTextFormFieldWidgetState createState() =>
      _SearchTextFormFieldWidgetState();
}

class _SearchTextFormFieldWidgetState extends State<SearchTextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: widget.backColor,
                borderRadius: BorderRadius.circular(kDefaultPadding / 4)),
            child: TextFormField(
              maxLines: widget.maxLines,
              style: TextStyle(color: widget.textColor),
              textAlign: TextAlign.left,
              controller: widget.editCtrller,
              keyboardType: widget.inputType,
              maxLength: widget.maxLength,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              obscureText: widget.isObsCured ?? false,
              inputFormatters: [
                widget.inputType == TextInputType.number ||
                        widget.inputType == TextInputType.phone
                    ? FilteringTextInputFormatter.digitsOnly
                    : FilteringTextInputFormatter.deny(RegExp('[]'))
              ],
              decoration: InputDecoration.collapsed(
                enabled: widget.isEnabled ?? true,
                // contentPadding:
                //     const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                hintText: widget.hintText,
                hintStyle: TextStyle(color: widget.textColor.withOpacity(0.5)),
                border: InputBorder.none,
                // focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
