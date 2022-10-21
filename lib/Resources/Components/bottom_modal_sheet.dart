import '../../Resources/Constants/responsive.dart';

import '../../Resources/Constants/global_variables.dart';
import 'package:flutter/material.dart';

showBottomModalSheet(
    {required BuildContext context,
    required Function callback,
    required Widget content}) {
  showModalBottomSheet(
      // isDismissible: false,
      // isScrollControlled: true,
      backgroundColor: AppColors.kTransparentColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      context: context,
      builder: (builder) {
        return FractionallySizedBox(
            // heightFactor: 0.6,
            widthFactor: Responsive.isMobile(context) ? 1 : 0.5,
            // padding: const EdgeInsets.all(0),
            // // height: MediaQuery.of(context).size.height /
            // //     (heightFactor == 2 ? 2 : heightFactor),
            // constraints: BoxConstraints(
            //     minHeight: 10,
            //     maxHeight: MediaQuery.of(context).size.height / 1.7,
            //     maxWidth: Responsive.isMobile(context)
            //         ? MediaQuery.of(context).size.width
            //         : MediaQuery.of(context).size.width / 2.5,
            //     minWidth: 50),
            // width: Responsive.isMobile(context)
            //     ? MediaQuery.of(context).size.width
            //     : MediaQuery.of(context).size.width / 2.5,
            child: Container(
              padding: const EdgeInsets.only(bottom: 16),
              constraints: BoxConstraints(
                minHeight: 10,
                maxHeight: MediaQuery.of(context).size.height / 1.7,
              ),
              decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  color: AppColors.kPrimaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                          color: AppColors.kWhiteColor,
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                  // TextWidgets.textBold(
                  //               align: TextAlign.center,
                  //               title: title,
                  //               fontSize: 14,
                  //               textColor: AppColors.kBlackColor),
                  //           const SizedBox(
                  //             height: 15,
                  //           ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [Row(), content],
                      ),
                    ),
                  )
                ],
              ),
            ));
      });
}
