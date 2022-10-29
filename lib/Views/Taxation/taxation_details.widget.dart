import 'package:flutter/material.dart';
import 'package:tax_payment_app/Resources/Components/list_item.dart';
import 'package:tax_payment_app/Resources/Components/texts.dart';
import 'package:tax_payment_app/Resources/Constants/global_variables.dart';
import 'package:tax_payment_app/Resources/Helpers/date_parser.dart';
import 'package:tax_payment_app/Resources/Models/Menu/list_item.model.dart';
import 'package:tax_payment_app/Resources/Models/taxation.mode.dart';

class TaxationDetails extends StatelessWidget {
  TaxationModel data;
  TaxationDetails({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.kTransparentColor,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextWidgets.textBold(
                  title: "Liquidation",
                  fontSize: 18,
                  textColor: AppColors.kWhiteColor),
            ),
            Card(
              margin: const EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              color: AppColors.kScaffoldColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(),
                    TextWidgets.text300(
                        icon: Icons.attach_money,
                        title: data.totalAmount,
                        fontSize: 18,
                        textColor: AppColors.kWhiteColor),
                    const SizedBox(height: 6),
                    TextWidgets.text300(
                        icon: Icons.calendar_today,
                        title: parseDate(date: data.createdAt ?? '0000-00-00'),
                        fontSize: 18,
                        textColor: AppColors.kWhiteColor),
                    const SizedBox(height: 6),
                    TextWidgets.text300(
                        icon: Icons.account_tree_sharp,
                        title: data.status ?? '',
                        fontSize: 18,
                        textColor: AppColors.kWhiteColor),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextWidgets.textBold(
                  title: "Assujetis",
                  fontSize: 18,
                  textColor: AppColors.kWhiteColor),
            ),
            Card(
              margin: const EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              color: AppColors.kScaffoldColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(),
                    TextWidgets.text300(
                        icon: Icons.person,
                        title: data.client?.fullname ?? '',
                        fontSize: 18,
                        textColor: AppColors.kWhiteColor),
                    const SizedBox(height: 6),
                    TextWidgets.text300(
                        icon: Icons.phone,
                        title: data.client?.phone ?? '',
                        fontSize: 18,
                        textColor: AppColors.kWhiteColor),
                    const SizedBox(height: 6),
                    TextWidgets.text300(
                        icon: Icons.mail,
                        title: data.client?.email ?? '',
                        fontSize: 18,
                        textColor: AppColors.kWhiteColor),
                    const SizedBox(height: 6),
                    TextWidgets.text300(
                        icon: Icons.payment,
                        title: data.client?.nationalID ?? '',
                        fontSize: 18,
                        textColor: AppColors.kWhiteColor),
                    const SizedBox(height: 6),
                    TextWidgets.text300(
                        icon: Icons.payment,
                        title: data.client?.impotID ?? '',
                        fontSize: 18,
                        textColor: AppColors.kWhiteColor),
                    const SizedBox(height: 6),
                    TextWidgets.text300(
                        icon: Icons.location_city,
                        title: data.client?.postalCode ?? '',
                        fontSize: 18,
                        textColor: AppColors.kWhiteColor),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextWidgets.textBold(
                  title: "Taxes",
                  fontSize: 18,
                  textColor: AppColors.kWhiteColor),
            ),
            Card(
              margin: const EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              color: AppColors.kScaffoldColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...List.generate(
                        data.taxes?.length ?? 0,
                        (index) => ListItem(
                              icon: data.taxes?[index].status
                                          .toString()
                                          .toLowerCase() ==
                                      'pending'
                                  ? Icons.history
                                  : Icons.check_circle,
                              title: data.taxes?[index].taxName ?? 'Unknown',
                              subtitle: data.taxes?[index].taxDescription ??
                                  'Unknown',
                              detailsFields: [
                                if (data.taxes?[index].taxeInfo != null)
                                  ...List.generate(
                                      data.taxes![index].taxeInfo!.length,
                                      (indexInfo) => ListItemModel(
                                          title: data.taxes?[index]
                                                      .taxeInfo![indexInfo]
                                                  ['name'] ??
                                              '',
                                          value: data.taxes?[index]
                                                      .taxeInfo![indexInfo]
                                                  ['value'] ??
                                              ''))
                              ],
                              middleFields: ListItemModel(
                                  displayLabel: false,
                                  icon: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: AppColors.kWhiteColor,
                                    ),
                                    child: TextWidgets.text300(
                                        title:
                                            "FC ${data.taxes?[index].amountPaid}",
                                        fontSize: 12,
                                        textColor: AppColors.kBlackColor),
                                  ),
                                  title:
                                      data.taxes?[index].status ?? 'Pending...',
                                  value: data.taxes?[index].status ??
                                      'Pending...'),
                              backColor: AppColors.kBlackLightColor,
                              textColor: AppColors.kWhiteColor,
                              keepMidleFields: true,
                            )),
                    Row(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
