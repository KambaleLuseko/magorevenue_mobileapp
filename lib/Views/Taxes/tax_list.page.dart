import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:tax_payment_app/Resources/Components/list_item.dart';
import 'package:tax_payment_app/Resources/Constants/global_variables.dart';
import 'package:tax_payment_app/Resources/Models/Menu/list_item.model.dart';
import 'package:tax_payment_app/Resources/Providers/client.provider.dart';
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
        body: Column(
      children: [
        Expanded(
            child: ListView.builder(
                itemCount: context
                    .select<TaxationProvider, List>(
                        (provider) => provider.currentDivision!.taxes!)
                    .length,
                itemBuilder: (context, index) {
                  return ListItem(
                    icon: Icons.payment,
                    title: context
                        .read<TaxationProvider>()
                        .currentDivision!
                        .taxes![index]
                        .name,
                    subtitle: context
                            .read<TaxationProvider>()
                            .currentDivision!
                            .taxes![index]
                            .description ??
                        '',
                    detailsFields: [
                      ListItemModel(
                        title: 'Montant',
                        value:
                            "CDF ${context.read<TaxationProvider>().currentDivision!.taxes![index].montant_du}",
                      ),
                      ListItemModel(
                        title: 'Pourcentage',
                        value:
                            "${context.read<TaxationProvider>().currentDivision!.taxes![index].pourcentage}%",
                      ),
                    ],
                    keepMidleFields: true,
                    middleFields: ListItemModel(
                      displayLabel: false,
                      title: 'Status',
                      value: context
                                  .read<TaxationProvider>()
                                  .currentDivision!
                                  .taxes![index]
                                  .syncStatus ==
                              1
                          ? 'Synced'
                          : 'Offline',
                      icon: Icon(
                          context
                                      .read<TaxationProvider>()
                                      .currentDivision!
                                      .taxes![index]
                                      .syncStatus ==
                                  1
                              ? Icons.cloud_done_rounded
                              : Icons.watch_later_rounded,
                          color: AppColors.kWhiteColor),
                    ),
                    backColor: AppColors.kScaffoldColor,
                    textColor: AppColors.kWhiteColor,
                  );
                }))
      ],
    ));
  }
}
