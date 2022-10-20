import 'package:tax_payment_app/Resources/Components/texts.dart';
import 'package:tax_payment_app/Resources/Constants/enums.dart';
import 'package:tax_payment_app/Resources/Constants/responsive.dart';
import 'package:tax_payment_app/main.dart';
import 'package:flutter/material.dart';

Map<String, String> headers = {
  // 'Accept': 'application/json; charset=UTF-8',
  'Content-Type': 'application/json',
  // 'Authorization': 'Bearer ${Provider.of<AppStateProvider>(navKey.currentContext!, listen: false).userToken}'
};

double kDefaultPadding = 20;

class AppColors {
  static Color kPrimaryColor = const Color.fromRGBO(24, 24, 24, 1);
  static Color kSecondaryColor = const Color.fromRGBO(60, 60, 60, 1);
  static Color kScaffoldColor = const Color.fromRGBO(60, 60, 60, 1);
  static Color kAccentColor = const Color.fromRGBO(40, 40, 40, 1);
  static Color kBlackColor = const Color.fromRGBO(0, 0, 0, 1);

  // static Color kBlackColor = Colors.black;
  static Color kBlackLightColor = const Color.fromRGBO(40, 40, 40, 1);
  static Color kWhiteColor = Colors.white;
  static Color kWhiteDarkColor = Colors.grey.shade400;
  static Color kGreenColor = Colors.green;
  static Color kRedColor = Colors.red;
  static Color kBlueColor = Colors.blue;
  static Color kGreyColor = Colors.grey;
  static Color kWarningColor = Colors.orange;

  // static Color kYellowColor = const Color.fromRGBO(255, 184, 57, 1);
  static Color kYellowColor = const Color.fromRGBO(255, 185, 35, 1);
  static Color kTextFormWhiteColor = Colors.white.withOpacity(0.05);
  static Color kTextFormBackColor = Colors.black.withOpacity(0.08);
  static Color kTransparentColor = Colors.transparent;
}

class BaseUrl {
  // static String ip = "https://binjafloraapp.herokuapp.com";
  static String ip = "http://127.0.0.1:3000";
  static String apiUrl = "$ip/api";
  static String getLogin = '$apiUrl/user/login/';
  static String user = '$apiUrl/users/';
  static String clients = '$apiUrl/clients/';
  static String client_taxes = '$apiUrl/client-taxes/';
  static String taxes = '$apiUrl/taxes/';
  static String divisions = '$apiUrl/divisions/';
  static String taxations = '$apiUrl/taxation/';
  static String stats = '$apiUrl/stats/';

  //=================User========================
}

class ToastNotification {
  static showToast(
      {required String msg,
      String? title = "Information",
      Alignment? align = Alignment.topCenter,
      MessageType? msgType = MessageType.warning}) {
    ScaffoldMessenger.of(navKey.currentContext!).removeCurrentSnackBar();
    ScaffoldMessenger.of(navKey.currentContext!).showSnackBar(
      SnackBar(
        elevation: 5,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        margin: Responsive.isWeb(navKey.currentContext!)
            ? EdgeInsets.only(
                left: align == Alignment.center
                    ? MediaQuery.of(navKey.currentContext!).size.width / 2.5
                    : MediaQuery.of(navKey.currentContext!).size.width / 1.3,
                right: align == Alignment.center
                    ? MediaQuery.of(navKey.currentContext!).size.width / 2.5
                    : 8,
                bottom: 8)
            : const EdgeInsets.only(left: 8, right: 8, bottom: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: AppColors.kWhiteColor,
        content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.kWhiteColor,
              // msgType == MessageType.error
              //     ? AppColors.kRedColor.withOpacity(0.1)
              //     : msgType == MessageType.success
              //         ? AppColors.kGreenColor.withOpacity(0.1)
              //         : AppColors.kWarningColor.withOpacity(0.1),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 35,
                  height: 35,
                  // padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: AppColors.kWhiteColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    msgType == MessageType.info
                        ? Icons.info
                        : msgType == MessageType.error
                            ? Icons.cancel
                            : msgType == MessageType.success
                                ? Icons.check_circle
                                : Icons.warning_amber_rounded,
                    color: msgType == MessageType.info
                        ? AppColors.kBlueColor
                        : msgType == MessageType.error
                            ? AppColors.kRedColor
                            : msgType == MessageType.success
                                ? AppColors.kGreenColor
                                : AppColors.kWarningColor,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextWidgets.textBold(
                            title: title!,
                            fontSize: 18,
                            textColor: msgType == MessageType.info
                                ? AppColors.kBlueColor
                                : msgType == MessageType.error
                                    ? AppColors.kRedColor
                                    : msgType == MessageType.success
                                        ? AppColors.kGreenColor
                                        : AppColors.kWarningColor),
                        TextWidgets.textNormal(
                            title: msg,
                            fontSize: 14,
                            textColor: msgType == MessageType.info
                                ? AppColors.kBlueColor
                                : msgType == MessageType.error
                                    ? AppColors.kRedColor
                                    : msgType == MessageType.success
                                        ? AppColors.kGreenColor
                                        : AppColors.kWarningColor),
                      ]),
                ),
              ],
            )),
      ),
    );
  }
}
