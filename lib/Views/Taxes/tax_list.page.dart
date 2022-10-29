import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:tax_payment_app/Resources/Components/bottom_modal_sheet.dart';
import 'package:tax_payment_app/Resources/Components/list_item.dart';
import 'package:tax_payment_app/Resources/Components/texts.dart';
import 'package:tax_payment_app/Resources/Constants/global_variables.dart';
import 'package:tax_payment_app/Resources/Models/Menu/list_item.model.dart';
import 'package:tax_payment_app/Resources/Providers/client.provider.dart';
import 'package:tax_payment_app/Resources/Providers/division.provider.dart';
import 'package:tax_payment_app/Resources/Providers/taxation.provider.dart';

class TaxListPage extends StatefulWidget {
  const TaxListPage({Key? key}) : super(key: key);

  @override
  State<TaxListPage> createState() => _TaxListPageState();
}

class _TaxListPageState extends State<TaxListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: () async {
        context.read<DivisionProvider>().get(isRefresh: true);
      },
      child: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: context
                      .select<DivisionProvider, List>(
                          (provider) => provider.currentDivision!.taxes!)
                      .length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.kBlackLightColor,
                      ),
                      child: ListTile(
                        onTap: () async {
                          await showBottomModalSheet(
                              context: context,
                              callback: () {},
                              content: Material(
                                color: AppColors.kTransparentColor,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextWidgets.textBold(
                                            title: "Details taxe",
                                            fontSize: 18,
                                            textColor: AppColors.kWhiteColor),
                                      ),
                                      Card(
                                        margin: const EdgeInsets.all(8),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        color: AppColors.kScaffoldColor,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(),
                                              TextWidgets.textWithLabel(
                                                fontSize: 14,
                                                textColor:
                                                    AppColors.kWhiteColor,
                                                title: 'Montant',
                                                value:
                                                    "CDF ${context.read<DivisionProvider>().currentDivision!.taxes![index].montant_du}",
                                              ),
                                              TextWidgets.textWithLabel(
                                                fontSize: 14,
                                                textColor:
                                                    AppColors.kWhiteColor,
                                                title: 'Pourcentage',
                                                value:
                                                    "${context.read<DivisionProvider>().currentDivision!.taxes![index].pourcentage}%",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextWidgets.textBold(
                                            title:
                                                "Informations supplémentaires",
                                            fontSize: 18,
                                            textColor: AppColors.kWhiteColor),
                                      ),
                                      Card(
                                        margin: const EdgeInsets.all(8),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        color: AppColors.kScaffoldColor,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(),
                                              ...List.generate(
                                                context
                                                    .read<DivisionProvider>()
                                                    .currentDivision!
                                                    .taxes![index]
                                                    .inputs
                                                    .length,
                                                (indexInput) =>
                                                    TextWidgets.textWithLabel(
                                                  fontSize: 14,
                                                  textColor:
                                                      AppColors.kWhiteColor,
                                                  title: context
                                                      .read<DivisionProvider>()
                                                      .currentDivision!
                                                      .taxes![index]
                                                      .inputs[indexInput]
                                                      .name,
                                                  value: context
                                                              .read<
                                                                  DivisionProvider>()
                                                              .currentDivision!
                                                              .taxes![index]
                                                              .inputs[
                                                                  indexInput]
                                                              .isRequired ==
                                                          1
                                                      ? 'Requis'
                                                      : 'Optionel',
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ));
                        },
                        contentPadding: const EdgeInsets.all(8),
                        leading: Icon(
                          Icons.payment,
                          color: AppColors.kWhiteColor,
                          size: 40,
                        ),
                        title: TextWidgets.textBold(
                            title: context
                                    .read<TaxationProvider>()
                                    .homeData[index]
                                    .uuid ??
                                '',
                            fontSize: 18,
                            textColor: AppColors.kWhiteColor),
                        subtitle: TextWidgets.text300(
                            title: context
                                    .read<TaxationProvider>()
                                    .homeData[index]
                                    .status ??
                                '',
                            fontSize: 14,
                            textColor: AppColors.kWhiteColor),
                        trailing: Icon(
                            context
                                        .read<DivisionProvider>()
                                        .currentDivision!
                                        .taxes![index]
                                        .syncStatus ==
                                    1
                                ? Icons.cloud_done_rounded
                                : Icons.watch_later_rounded,
                            color: AppColors.kWhiteColor),
                      ),
                    );
                    // return ListItem(
                    //   icon: Icons.payment,
                    //   title: context
                    //       .read<DivisionProvider>()
                    //       .currentDivision!
                    //       .taxes![index]
                    //       .name,
                    //   subtitle: context
                    //           .read<DivisionProvider>()
                    //           .currentDivision!
                    //           .taxes![index]
                    //           .description ??
                    //       '',
                    //   detailsFields: [
                    //     ListItemModel(
                    //       title: 'Montant',
                    //       value:
                    //           "CDF ${context.read<DivisionProvider>().currentDivision!.taxes![index].montant_du}",
                    //     ),
                    //     ListItemModel(
                    //       title: 'Pourcentage',
                    //       value:
                    //           "${context.read<DivisionProvider>().currentDivision!.taxes![index].pourcentage}%",
                    //     ),
                    //   ],
                    //   keepMidleFields: true,
                    //   middleFields: ListItemModel(
                    //     displayLabel: false,
                    //     title: 'Status',
                    //     value: context
                    //                 .read<DivisionProvider>()
                    //                 .currentDivision!
                    //                 .taxes![index]
                    //                 .syncStatus ==
                    //             1
                    //         ? 'Synced'
                    //         : 'Offline',
                    //     icon: Icon(
                    //         context
                    //                     .read<DivisionProvider>()
                    //                     .currentDivision!
                    //                     .taxes![index]
                    //                     .syncStatus ==
                    //                 1
                    //             ? Icons.cloud_done_rounded
                    //             : Icons.watch_later_rounded,
                    //         color: AppColors.kWhiteColor),
                    //   ),
                    //   backColor: AppColors.kScaffoldColor,
                    //   textColor: AppColors.kWhiteColor,
                    // );
                  }))
        ],
      ),
    ));
  }
}
