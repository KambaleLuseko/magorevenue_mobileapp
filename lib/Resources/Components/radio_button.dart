import '../../Resources/Constants/global_variables.dart';
import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  final String label;
  bool value;
  final Color textColor;
  Function callBack;
  CustomRadioButton(
      {Key? key,
      required this.value,
      required this.label,
      required this.textColor,
      required this.callBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callBack();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(color: textColor),
            ),
            const SizedBox(
              height: 0,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              decoration: BoxDecoration(
                  color: AppColors.kTextFormWhiteColor,
                  borderRadius: BorderRadius.circular(kDefaultPadding)),
              child: Icon(
                value == true
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
