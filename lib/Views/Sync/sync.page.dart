import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_payment_app/Resources/Components/texts.dart';
import 'package:tax_payment_app/Resources/Constants/global_variables.dart';
import 'package:tax_payment_app/Resources/Providers/app_state_provider.dart';
import 'package:tax_payment_app/Resources/Providers/client.provider.dart';
import 'package:tax_payment_app/Resources/Providers/taxation.provider.dart';

class SyncDataPage extends StatefulWidget {
  const SyncDataPage({Key? key}) : super(key: key);

  @override
  State<SyncDataPage> createState() => _SyncDataPageState();
}

class _SyncDataPageState extends State<SyncDataPage> {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: context
          .select<AppStateProvider, bool>((provider) => provider.isAsync),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Synchronisation'),
        ),
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: AppColors.kAccentColor,
            icon: const Icon(
              Icons.sync,
            ),
            onPressed: () async {
              context.read<ClientProvider>().syncOfflineData();
              context.read<TaxationProvider>().syncOfflineData();
              setState(() {});
            },
            label: TextWidgets.text300(
                title: context.select<AppStateProvider, bool>(
                            (provider) => provider.isAsync) ==
                        false
                    ? 'Synchroniser'
                    : "En cours...",
                fontSize: 14,
                textColor: AppColors.kWhiteColor)),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextWidgets.textBold(
                  title: 'Données à synchroniser',
                  fontSize: 14,
                  textColor: AppColors.kWhiteColor,
                ),
              ),
              Card(
                color: AppColors.kTextFormWhiteColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidgets.textHorizontalWithLabel(
                          title: 'Liquidation',
                          fontSize: 14,
                          textColor: AppColors.kWhiteColor,
                          value: context
                              .read<TaxationProvider>()
                              .getDataToSync()
                              .length
                              .toString()),
                      Divider(
                        color: AppColors.kTextFormWhiteColor,
                        thickness: 1,
                      ),
                      TextWidgets.textHorizontalWithLabel(
                          title: 'Assujetis',
                          fontSize: 14,
                          textColor: AppColors.kWhiteColor,
                          value: context
                              .read<ClientProvider>()
                              .getDataToSync()
                              .length
                              .toString()),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
