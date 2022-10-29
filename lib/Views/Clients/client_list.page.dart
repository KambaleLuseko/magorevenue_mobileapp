import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:tax_payment_app/Resources/Components/list_item.dart';
import 'package:tax_payment_app/Resources/Constants/global_variables.dart';
import 'package:tax_payment_app/Resources/Models/Menu/list_item.model.dart';
import 'package:tax_payment_app/Resources/Providers/client.provider.dart';

class ClientListPage extends StatefulWidget {
  const ClientListPage({Key? key}) : super(key: key);

  @override
  State<ClientListPage> createState() => _ClientListPageState();
}

class _ClientListPageState extends State<ClientListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: () async {
        context.read<ClientProvider>().get(isRefresh: true);
      },
      child: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: context
                      .select<ClientProvider, List>(
                          (provider) => provider.offlineData)
                      .length,
                  itemBuilder: (context, index) {
                    return ListItem(
                      icon: Icons.person,
                      title: context
                          .read<ClientProvider>()
                          .offlineData[index]
                          .fullname,
                      subtitle: context
                          .read<ClientProvider>()
                          .offlineData[index]
                          .phone,
                      detailsFields: [
                        ListItemModel(
                          title: 'Email',
                          value: context
                                  .read<ClientProvider>()
                                  .offlineData[index]
                                  .email ??
                              '',
                        ),
                        ListItemModel(
                          title: 'ID Nat',
                          value: context
                                  .read<ClientProvider>()
                                  .offlineData[index]
                                  .nationalID ??
                              '',
                        ),
                        ListItemModel(
                          title: 'No impot',
                          value: context
                                  .read<ClientProvider>()
                                  .offlineData[index]
                                  .impotID ??
                              '',
                        ),
                        ListItemModel(
                          title: 'BP',
                          value: context
                                  .read<ClientProvider>()
                                  .offlineData[index]
                                  .postalCode ??
                              '',
                        ),
                      ],
                      keepMidleFields: true,
                      middleFields: ListItemModel(
                        displayLabel: false,
                        title: 'Status',
                        value: context
                                    .read<ClientProvider>()
                                    .offlineData[index]
                                    .syncStatus ==
                                1
                            ? 'Synced'
                            : 'Offline',
                        icon: Icon(
                            context
                                        .read<ClientProvider>()
                                        .offlineData[index]
                                        .syncStatus ==
                                    1
                                ? Icons.cloud_done_rounded
                                : Icons.watch_later_rounded,
                            color: AppColors.kWhiteColor),
                      ),
                      backColor: AppColors.kBlackLightColor,
                      textColor: AppColors.kWhiteColor,
                    );
                  }))
        ],
      ),
    ));
  }
}
