import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_payment_app/Resources/Components/bottom_modal_sheet.dart';
import 'package:tax_payment_app/Resources/Components/texts.dart';
import 'package:tax_payment_app/Resources/Constants/global_variables.dart';
import 'package:tax_payment_app/Resources/Constants/navigators.dart';
import 'package:tax_payment_app/Resources/Models/taxation.mode.dart';
import 'package:tax_payment_app/Resources/Providers/taxation.provider.dart';
import 'package:tax_payment_app/Views/Taxation/new_taxation.page.dart';
import 'package:tax_payment_app/Views/Taxation/taxation_details.widget.dart';
import 'package:tax_payment_app/Views/menu.dart';

class TaxationListPage extends StatefulWidget {
  bool? displayAll;
  // DivisionModel data;
  TaxationListPage({Key? key, this.displayAll = false}) : super(key: key);

  @override
  State<TaxationListPage> createState() => _TaxationListPageState();
}

class _TaxationListPageState extends State<TaxationListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      context.read<TaxationProvider>().get();
      data = widget.displayAll == true
          ? context.read<TaxationProvider>().offlineData
          : context.read<TaxationProvider>().offlineData.length > 20
              ? context.read<TaxationProvider>().offlineData.sublist(0, 20)
              : context.read<TaxationProvider>().offlineData;
      setState(() {});
    });
  }

  List<TaxationModel> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Liquidations"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<TaxationProvider>().get(isRefresh: true);
        },
        child: Column(
          children: [
            TextWidgets.textBold(
                title: "Division de Santé",
                fontSize: 22,
                textColor: AppColors.kWhiteColor),
            const SizedBox(
              height: 24,
            ),
            // Container(
            //   width: double.maxFinite,
            //   height: 150,
            //   padding: const EdgeInsets.all(0),
            //   child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       itemCount: context
            //           .read<TaxationProvider>()
            //           .currentDivision!
            //           .taxes!
            //           .length,
            //       itemBuilder: (context, index) {
            //         return ListItemHome(
            //             data: context
            //                 .read<TaxationProvider>()
            //                 .currentDivision!
            //                 .taxes![index]
            //                 .toJSON());
            //       }),
            // ),
            // const SizedBox(
            //   height: 16,
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       TextWidgets.textNormal(
            //           title: "Taxations",
            //           fontSize: 18,
            //           textColor: AppColors.kWhiteColor),
            //       TextWidgets.text300(
            //           title: "Voir tout",
            //           fontSize: 12,
            //           textColor: AppColors.kWhiteColor),
            //     ],
            //   ),
            // ),
            Expanded(
              child: ListView.builder(
                  itemCount: context
                      .select<TaxationProvider, List<TaxationModel>>(
                          (provider) => provider.offlineData)
                      .length,
                  itemBuilder: (context, index) {
                    // print(context
                    //     .read<TaxationProvider>()
                    //     .offlineData[index]
                    //     .syncStatus);
                    DateTime createDate = DateTime.parse(context
                            .read<TaxationProvider>()
                            .offlineData[index]
                            .createdAt ??
                        '0000-00-00');
                    return Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.kScaffoldColor,
                      ),
                      child: ListTile(
                        onTap: () async {
                          await showBottomModalSheet(
                              context: context,
                              callback: () {},
                              content: TaxationDetails(
                                  data: context
                                      .read<TaxationProvider>()
                                      .offlineData[index]));
                        },
                        contentPadding: const EdgeInsets.all(8),
                        leading: Icon(
                          context
                                      .read<TaxationProvider>()
                                      .offlineData[index]
                                      .syncStatus ==
                                  1
                              ? Icons.cloud_done_rounded
                              : Icons.watch_later_sharp,
                          color: AppColors.kWhiteColor,
                          size: 56,
                        ),
                        title: TextWidgets.textBold(
                            title: context
                                    .read<TaxationProvider>()
                                    .offlineData[index]
                                    .uuid ??
                                '',
                            fontSize: 18,
                            textColor: AppColors.kWhiteColor),
                        subtitle: TextWidgets.text300(
                            title: context
                                    .read<TaxationProvider>()
                                    .offlineData[index]
                                    .status ??
                                '',
                            fontSize: 14,
                            textColor: AppColors.kWhiteColor),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.kWhiteColor,
                          ),
                          child: TextWidgets.text300(
                              title:
                                  "FC ${context.read<TaxationProvider>().offlineData[index].amount}",
                              fontSize: 12,
                              textColor: AppColors.kBlackColor),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class ListItemHome extends StatelessWidget {
  final Map data;
  const ListItemHome({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // print(data);
        // Navigation.pushNavigate(
        //     page: AddNewClientPage(data: DivisionModel.fromJSON(data)));
      },
      child: Container(
          width: 300,
          // height: 80,
          padding: const EdgeInsets.all(4),
          child: Stack(
            children: [
              Container(
                height: 136,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: AppColors.kBlackLightColor,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextWidgets.textBold(
                        maxLines: 2,
                        title: data['name'],
                        fontSize: 18,
                        textColor: AppColors.kWhiteColor),
                    const SizedBox(height: 8),
                    TextWidgets.text300(
                        maxLines: 2,
                        title: data['description'],
                        fontSize: 14,
                        textColor: AppColors.kWhiteDarkColor),
                    const Spacer(),
                    TextWidgets.textBold(
                        title:
                            "CDF ${(double.parse(data['montant_du']) * double.parse(data['pourcentage'])) / 100}",
                        fontSize: 20,
                        textColor: AppColors.kRedColor),
                    // TextWidgets.text300(
                    //     title: "Payable ${data['cycle'].toString()} fois",
                    //     fontSize: 14,
                    //     textColor: AppColors.kWhiteDarkColor),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
