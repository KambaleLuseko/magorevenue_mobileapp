import '../../Resources/Constants/global_variables.dart';
import '../../main.dart';
import 'package:flutter/material.dart';

showDatePicketCustom({required Function callback}) async {
  await showDatePicker(
    context: navKey.currentContext!,
    initialDate: DateTime.now(),
    firstDate: DateTime.now().subtract(const Duration(days: 62)),
    lastDate: DateTime.now(),
    builder: (BuildContext context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: AppColors.kPrimaryColor,
          accentColor: AppColors.kPrimaryColor,
          colorScheme: ColorScheme.light(primary: AppColors.kPrimaryColor),
          buttonTheme:
              const ButtonThemeData(textTheme: ButtonTextTheme.primary),
        ),
        child: child!,
      );
    },
  ).then((value) => callback(value)).catchError((error) {});
}
