import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:tax_payment_app/Resources/Components/texts.dart';
import 'package:tax_payment_app/Resources/Constants/global_variables.dart';
import 'package:tax_payment_app/Resources/Constants/navigators.dart';
import 'package:tax_payment_app/Resources/Constants/responsive.dart';
import 'package:tax_payment_app/Resources/Models/division.model.dart';
import 'package:tax_payment_app/Resources/Providers/client.provider.dart';
import 'package:tax_payment_app/Resources/Providers/division.provider.dart';
import 'package:tax_payment_app/Resources/Providers/taxation.provider.dart';
import 'package:tax_payment_app/Views/Clients/add_client.page.dart';
import 'package:tax_payment_app/Views/Home/home.page.dart';

class DivisionPage extends StatefulWidget {
  const DivisionPage({Key? key}) : super(key: key);

  @override
  State<DivisionPage> createState() => _HomePageState();
}

class _HomePageState extends State<DivisionPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await context.read<DivisionProvider>().get();
      await context.read<ClientProvider>().get();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Mago Revenue"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextWidgets.textBold(
                title: "Choisissez votre division",
                fontSize: 22,
                textColor: AppColors.kWhiteColor),
            const SizedBox(
              height: 24,
            ),
            Wrap(
              children: [
                ...List.generate(
                    context
                        .select<DivisionProvider, List<DivisionModel>>(
                            (value) => value.offlineData)
                        .length,
                    (index) => ListItemHome(
                        data: context
                            .select<DivisionProvider, List<DivisionModel>>(
                                (value) => value.offlineData)[index]
                            .toJSON())),
              ],
            )
            // GridView.builder(
            //   shrinkWrap: true,
            //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 2,
            //       mainAxisSpacing: 2,
            //       crossAxisSpacing: 2,
            //       childAspectRatio: 2 / 1.8),
            //   itemCount: data.length,
            //   itemBuilder: (context, index) {
            //     return ListItemHome(data: data[index]);
            //   },
            // )
          ],
        ),
      ),
    );
  }
}

class ListItemHome extends StatelessWidget {
  Map data;
  ListItemHome({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context
            .read<TaxationProvider>()
            .setDivision(DivisionModel.fromJSON(data));
        Navigation.pushReplaceNavigate(page: HomePage());
      },
      child: Container(
          width: MediaQuery.of(context).size.width / 2,
          padding: const EdgeInsets.all(4),
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: AppColors.kBlackLightColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(48),
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16))),
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
                        title: data['description'],
                        fontSize: 14,
                        textColor: AppColors.kWhiteDarkColor),
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
