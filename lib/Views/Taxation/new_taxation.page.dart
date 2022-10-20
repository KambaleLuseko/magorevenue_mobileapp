import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_payment_app/Resources/Components/texts.dart';
import 'package:tax_payment_app/Resources/Constants/enums.dart';
import 'package:tax_payment_app/Resources/Constants/global_variables.dart';
import 'package:tax_payment_app/Resources/Helpers/uuid_generator.dart';
import 'package:tax_payment_app/Resources/Models/Menu/list_item.model.dart';
import 'package:tax_payment_app/Resources/Models/division.model.dart';
import 'package:tax_payment_app/Resources/Models/partner.model.dart';
import 'package:tax_payment_app/Resources/Providers/app_state_provider.dart';
import 'package:tax_payment_app/Resources/Providers/taxation.provider.dart';
import 'package:tax_payment_app/Views/Taxation/choose_client.widget.dart';
import 'package:tax_payment_app/Views/Taxation/choose_taxes.widget.dart';
import 'package:tax_payment_app/Views/Taxation/resume.widget.dart';
import 'package:tax_payment_app/Views/Home/home.page.dart';

class AddNewTaxationPage extends StatefulWidget {
  DivisionModel data;
  AddNewTaxationPage({Key? key, required this.data}) : super(key: key);

  @override
  State<AddNewTaxationPage> createState() => _AddNewTaxationPageState();
}

class _AddNewTaxationPageState extends State<AddNewTaxationPage> {
  int currentPage = 0;
  late PageController _pageCtrller;
  ChooseClientWidget clientData = ChooseClientWidget();
  late ChooseClientTaxesWidget taxesData;
  ClientModel? client;
  @override
  void initState() {
    _pageCtrller = PageController(initialPage: currentPage, keepPage: false);
    taxesData = ChooseClientTaxesWidget(
      data: widget.data.taxes ?? [],
      transactionUUID: transUUID,
    );
    super.initState();
  }

  String transUUID = uuidGenerator();
  List<ListItemModel> titleSteppers = [
    ListItemModel(title: "Client", value: "Identité du client"),
    ListItemModel(
        title: "Taxes à payer", value: "Les taxes que le cleint doit payer"),
    ListItemModel(title: "Résumé", value: "Résumé de l'opération"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Liquidation"),
      ),
      body: Column(
        children: [
          Card(
            color: AppColors.kAccentColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          progressWidget(
                              title: "Etape",
                              max: 3,
                              value: currentPage + 1,
                              color: AppColors.kGreenColor),
                          const SizedBox(height: 8),
                          TextWidgets.text300(
                              title: "Etape ${currentPage + 1} sur 3",
                              fontSize: 12,
                              textColor: AppColors.kWhiteDarkColor)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextWidgets.textBold(
                              title: titleSteppers[currentPage].title,
                              fontSize: 24,
                              textColor: AppColors.kWhiteColor),
                          const SizedBox(height: 8),
                          TextWidgets.text300(
                              title: titleSteppers[currentPage].value,
                              fontSize: 12,
                              textColor: AppColors.kWhiteColor)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageCtrller,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: null,
              scrollDirection: Axis.horizontal,
              children: [
                clientData,
                taxesData,
                ResumeWidget(
                    callback: () {
                      currentPage = 0;
                      _pageCtrller.animateToPage(currentPage,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease);
                      setState(() {});
                    },
                    data: taxesData.choosedData!,
                    client: client)
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (currentPage < 2)
                InkWell(
                  onTap: () {
                    if (currentPage == 0) return;
                    currentPage--;
                    setState(() {});
                    _pageCtrller.animateToPage(currentPage,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease);
                  },
                  child: Card(
                    color: AppColors.kAccentColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 32),
                      child: TextWidgets.text500(
                          title: "Back",
                          fontSize: 18,
                          textColor: AppColors.kGreyColor),
                    ),
                  ),
                ),
              context.select<AppStateProvider, bool>(
                          (provider) => provider.isAsync) ==
                      false
                  ? InkWell(
                      onTap: () {
                        if (currentPage < 2) {
                          if (currentPage == 0) {
                            if (clientData.client?.fullname == null ||
                                clientData.client?.phone == null) {
                              ToastNotification.showToast(
                                  msg:
                                      "Veuillez remplir toutes les données du client",
                                  msgType: MessageType.error,
                                  title: "Erreur");
                              return;
                            }
                          }
                          client = clientData.client;
                          if (currentPage == 1) {
                            if (taxesData.choosedData!.isEmpty) {
                              ToastNotification.showToast(
                                  msg: "Veuillez choisir au moins une taxe",
                                  msgType: MessageType.error,
                                  title: "Erreur");
                              return;
                            }
                          }
                          currentPage++;
                          setState(() {});
                          _pageCtrller.animateToPage(currentPage,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease);
                        } else {
                          Map data = {
                            "uuid": transUUID,
                            "amount": taxesData.choosedData
                                ?.map((e) => double.parse(e.amount.toString()))
                                .reduce((prev, next) => prev + next),
                            "client": client?.toJSON(),
                            "status": 'Constatation',
                            "taxes": taxesData.choosedData
                                ?.map((e) => e.toJSON())
                                .toList()
                          };
                          // print(data);
                          // return;
                          context.read<TaxationProvider>().saveData(
                              data: data,
                              callback: () {
                                Navigator.pop(context);
                              });
                        }
                      },
                      child: Card(
                        color: AppColors.kAccentColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 32),
                          child: TextWidgets.text500(
                              title: currentPage < 2 ? "Next" : 'Enregistrer',
                              fontSize: 18,
                              textColor: AppColors.kWhiteColor),
                        ),
                      ),
                    )
                  : const Center(
                      child: SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white)))),
            ],
          ),
          const SizedBox(height: 16)
        ],
      ),
    );
  }
}
