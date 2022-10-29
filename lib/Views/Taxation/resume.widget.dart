import 'package:flutter/material.dart';
import 'package:tax_payment_app/Resources/Components/button.dart';
import 'package:tax_payment_app/Resources/Components/list_item.dart';
import 'package:tax_payment_app/Resources/Components/texts.dart';
import 'package:tax_payment_app/Resources/Constants/global_variables.dart';
import 'package:tax_payment_app/Resources/Helpers/date_parser.dart';
import 'package:tax_payment_app/Resources/Models/Menu/list_item.model.dart';
import 'package:tax_payment_app/Resources/Models/division.model.dart';
import 'package:tax_payment_app/Resources/Models/partner.model.dart';

class ResumeWidget extends StatefulWidget {
  List<TaxePaymentModel> data;
  ClientModel? client;
  Function callback;
  ResumeWidget(
      {Key? key, required this.data, this.client, required this.callback})
      : super(key: key);

  @override
  State<ResumeWidget> createState() => _ResumeWidgetState();
}

class _ResumeWidgetState extends State<ResumeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 24,
            ),
            TextWidgets.textBold(
                title: 'Client',
                fontSize: 18,
                textColor: AppColors.kWhiteColor),
            Card(
              color: AppColors.kAccentColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(),
                          TextWidgets.textBold(
                              title: widget.client?.fullname ?? '',
                              fontSize: 16,
                              textColor: AppColors.kWhiteColor),
                          const SizedBox(height: 8),
                          TextWidgets.text300(
                              icon: Icons.call,
                              title: widget.client?.phone ?? '',
                              fontSize: 14,
                              textColor: AppColors.kWhiteColor),
                          const SizedBox(height: 8),
                          TextWidgets.text300(
                              icon: Icons.mail,
                              title: widget.client?.email ?? '',
                              fontSize: 12,
                              textColor: AppColors.kWhiteColor),
                          const SizedBox(height: 8),
                          TextWidgets.text300(
                              icon: Icons.payment_rounded,
                              title: widget.client?.nationalID ?? '',
                              fontSize: 12,
                              textColor: AppColors.kWhiteColor),
                          const SizedBox(height: 8),
                          TextWidgets.text300(
                              icon: Icons.confirmation_number_rounded,
                              title: widget.client?.impotID ?? '',
                              fontSize: 12,
                              textColor: AppColors.kWhiteColor),
                          const SizedBox(height: 8),
                          TextWidgets.text300(
                              icon: Icons.location_pin,
                              title: widget.client?.postalCode ?? '',
                              fontSize: 12,
                              textColor: AppColors.kWhiteColor),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Icon(Icons.person,
                            size: 80, color: AppColors.kWhiteColor),
                        CustomButton(
                            isBordered: true,
                            size: 80,
                            text: "Changer",
                            backColor: AppColors.kTransparentColor,
                            textColor: AppColors.kRedColor,
                            callback: widget.callback)
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TextWidgets.textBold(
                title: 'Taxes à payer',
                fontSize: 18,
                textColor: AppColors.kWhiteColor),
            const SizedBox(
              height: 8,
            ),
            ...List.generate(
                widget.data.length,
                (index) => Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: AppColors.kAccentColor,
                    // shadowColor: AppColors.kTextFormWhiteColor,
                    child: ListItem(
                      title: widget.data[index].taxName!,
                      subtitle:
                          'Prochain paiement : ${parseDate(date: widget.data[index].nextPayment)}',
                      backColor: AppColors.kAccentColor,
                      textColor: AppColors.kWhiteColor,
                      detailsFields: [
                        ...List.generate(
                            widget.data[index].inputsData!.length,
                            (inputIndex) => ListItemModel(
                                  title: widget.data[index]
                                          .inputsData?[inputIndex]['name'] ??
                                      '',
                                  value: widget.data[index]
                                          .inputsData?[inputIndex]['value'] ??
                                      '',
                                  // icon: Icon(Icons.info,
                                  //     color: AppColors.kWhiteColor),
                                ))
                      ],
                      keepMidleFields: true,
                      middleFields: ListItemModel(
                        displayLabel: true,
                        title: 'Montant',
                        value: "CDF ${widget.data[index].amountPaid}",
                      ),
                    )

                    // ListTile(
                    //   title:
                    //       fontSize: 14,
                    //       textColor: AppColors.kWhiteColor),
                    //   subtitle: TextWidgets.text300(
                    //       title:
                    //           'Prochain paiement : ${parseDate(date: widget.data[index].dueDate)}',
                    //       fontSize: 14,
                    //       textColor: AppColors.kWhiteColor),
                    //   trailing: TextWidgets.text300(
                    //       title: "CDF ${widget.data[index].amount}",
                    //       fontSize: 14,
                    //       textColor: AppColors.kWhiteColor),
                    // ),
                    ))
          ],
        ),
      ),
    ));
  }
}
