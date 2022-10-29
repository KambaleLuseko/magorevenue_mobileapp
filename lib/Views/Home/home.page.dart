import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_payment_app/Resources/Components/bottom_modal_sheet.dart';
import 'package:tax_payment_app/Resources/Components/texts.dart';
import 'package:tax_payment_app/Resources/Constants/global_variables.dart';
import 'package:tax_payment_app/Resources/Constants/navigators.dart';
import 'package:tax_payment_app/Resources/Models/division.model.dart';
import 'package:tax_payment_app/Resources/Models/taxation.mode.dart';
import 'package:tax_payment_app/Resources/Providers/division.provider.dart';
import 'package:tax_payment_app/Resources/Providers/taxation.provider.dart';
import 'package:tax_payment_app/Resources/Providers/users_provider.dart';
import 'package:tax_payment_app/Views/Taxation/new_taxation.page.dart';
import 'package:tax_payment_app/Views/Taxation/taxation_details.widget.dart';
import 'package:tax_payment_app/Views/Taxation/taxation_list.page.dart';
import 'package:tax_payment_app/Views/menu.dart';

class HomePage extends StatefulWidget {
  // DivisionModel data;
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      context.read<UserProvider>().getUserData();
      context.read<TaxationProvider>().get();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: TextWidgets.text300(
            title: "Nouvelle liquidation",
            fontSize: 14,
            textColor: AppColors.kWhiteColor),
        icon: const Icon(Icons.add),
        isExtended: true,
        heroTag: 'constatation',
        backgroundColor: AppColors.kScaffoldColor,
        elevation: 8,
        // mini: true,
        onPressed: () {
          Navigation.pushNavigate(
              page: AddNewTaxationPage(
            data: context.read<DivisionProvider>().currentDivision!,
          ));
        },
      ),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Mago Revenue"),
      ),
      drawer: const Drawer(
        child: MenuWidget(),
      ),
      body: Column(
        children: [
          TextWidgets.textBold(
              title:
                  (context.read<DivisionProvider>().currentDivision?.name ?? '')
                      .toUpperCase(),
              fontSize: 22,
              textColor: AppColors.kWhiteColor),
          const SizedBox(
            height: 24,
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: AppColors.kBlackLightColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  progressWidget(
                      title: "Liquidations",
                      max: 100,
                      value: 48,
                      color: AppColors.kRedColor),
                  progressWidget(
                      title: "Perception",
                      max: 100,
                      value: 52,
                      color: AppColors.kYellowColor),
                  progressWidget(
                      title: "Paid",
                      max: 100,
                      value: 10,
                      color: AppColors.kGreenColor),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      legendWidget(
                          title: "Liquidations",
                          color: AppColors.kRedColor,
                          percent: (48 * 100) / 100),
                      legendWidget(
                          title: "Perception",
                          color: AppColors.kYellowColor,
                          percent: (52 * 100) / 100),
                      legendWidget(
                          title: "Paid",
                          color: AppColors.kGreenColor,
                          percent: (10 * 100) / 100),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(8.0),
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidgets.textBold(
                          title: "Taxes de la division",
                          fontSize: 18,
                          textColor: AppColors.kWhiteColor),
                      TextWidgets.text300(
                          title: "Voir tout",
                          fontSize: 12,
                          textColor: AppColors.kWhiteColor),
                    ],
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  height: 150,
                  padding: const EdgeInsets.all(0),
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: context
                          .select<DivisionProvider, DivisionModel>(
                              (provider) => provider.currentDivision!)
                          .taxes!
                          .length,
                      itemBuilder: (context, index) {
                        return ListItemHome(
                            data: context
                                .read<DivisionProvider>()
                                .currentDivision!
                                .taxes![index]
                                .toJSON());
                      }),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidgets.textBold(
                          title: "Liquidations",
                          fontSize: 18,
                          textColor: AppColors.kWhiteColor),
                      GestureDetector(
                        onTap: () {
                          Navigation.pushNavigate(page: TaxationListPage());
                        },
                        child: Container(
                          child: TextWidgets.text300(
                              title: "Voir tout",
                              fontSize: 12,
                              textColor: AppColors.kWhiteColor),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: context
                        .select<TaxationProvider, List<TaxationModel>>(
                            (provider) => provider.homeData)
                        .length,
                    itemBuilder: (context, index) {
                      DateTime createDate = DateTime.parse(context
                              .read<TaxationProvider>()
                              .homeData[index]
                              .createdAt ??
                          '0000-00-00');
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
                                content: TaxationDetails(
                                    data: context
                                        .read<TaxationProvider>()
                                        .homeData[index]));
                          },
                          contentPadding: const EdgeInsets.all(8),
                          leading: Icon(
                            context
                                        .read<TaxationProvider>()
                                        .homeData[index]
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
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.kWhiteColor,
                            ),
                            child: TextWidgets.text300(
                                title:
                                    "FC ${context.read<TaxationProvider>().homeData[index].totalAmount}",
                                fontSize: 12,
                                textColor: AppColors.kBlackColor),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ],
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
                width: double.maxFinite,
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
                            "CDF ${(double.parse(data['montant_du']) * double.parse(data['pourcentageAPayer'])) / 100}",
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

progressWidget(
    {required String title,
    required double max,
    required double value,
    required Color color}) {
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      // TextWidgets.text300(
      //     title: title, fontSize: 12, textColor: AppColors.kBlackColor),
      // const SizedBox(height: 8),
      LayoutBuilder(builder: (context, constraints) {
        // print(constraints.maxWidth)
        double percent = 0;
        if (max > 0) {
          percent = (value * 100) / max;
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: constraints.maxWidth,
              height: 10,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: (constraints.maxWidth) * (percent / 100),
                  height: 10,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ),
          ],
        );
      })
    ]),
  );
}

legendWidget(
    {required String title, required Color color, required double percent}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(50))),
        const SizedBox(
          width: 8,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidgets.textBold(
                title: title, fontSize: 12, textColor: AppColors.kWhiteColor),
            TextWidgets.text300(
                title: "${percent.toStringAsFixed(2)} %",
                fontSize: 12,
                textColor: AppColors.kWhiteColor)
          ],
        )
      ],
    ),
  );
}
