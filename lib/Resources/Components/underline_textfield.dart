import '../../Resources/Constants/global_variables.dart';
import 'package:flutter/material.dart';

class UnderlinedTextFormField extends StatefulWidget {
  final String hintText;
  final Color textColor;
  const UnderlinedTextFormField(
      {Key? key, required this.hintText, required this.textColor})
      : super(key: key);

  @override
  _UnderlinedTextFormFieldState createState() =>
      _UnderlinedTextFormFieldState();
}

class _UnderlinedTextFormFieldState extends State<UnderlinedTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: AppColors.kTextFormBackColor,
          borderRadius: BorderRadius.circular(kDefaultPadding / 4)),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: widget.textColor.withOpacity(0.5)),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: widget.textColor, width: 1)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: widget.textColor, width: 3)),
        ),
      ),
    );
  }
}
