import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:tax_payment_app/Resources/Components/search_page.component.dart';
import 'package:tax_payment_app/Resources/Components/texts.dart';
import 'package:tax_payment_app/Resources/Constants/global_variables.dart';
import 'package:tax_payment_app/Resources/Models/partner.model.dart';
import 'package:tax_payment_app/Resources/Providers/client.provider.dart';

class ChooseClientWidget extends StatefulWidget {
  ClientModel? client;
  ChooseClientWidget({Key? key, this.client}) : super(key: key);

  @override
  State<ChooseClientWidget> createState() => _ChooseClientWidgetState();
}

class _ChooseClientWidgetState extends State<ChooseClientWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            Image.asset(
              "Assets/Images/client_img.png",
            ),
            const SizedBox(
              height: 24,
            ),
            ListTile(
              onTap: () async {
                String client = await showSearch(
                    context: context,
                    delegate: CustomSearchPage(
                        data: context
                            .read<ClientProvider>()
                            .offlineData
                            .map((e) => e.toJSON())
                            .toList(),
                        firstSearchColumn: 'fullname',
                        secondSearchColumn: 'phone'));
                if (client == null || client == 'null') {
                  return;
                }
                widget.client = ClientModel.fromJSON(jsonDecode(client));
                setState(() {});
              },
              tileColor: AppColors.kScaffoldColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              title: TextWidgets.textBold(
                  title: widget.client?.fullname ?? 'Choisissez un client',
                  fontSize: 22,
                  textColor: AppColors.kWhiteColor),
              subtitle: TextWidgets.text300(
                  title: widget.client?.phone ?? 'Aucun client choisi',
                  fontSize: 16,
                  textColor: AppColors.kWhiteColor),
              trailing: Icon(
                  widget.client == null
                      ? Icons.arrow_forward_ios
                      : Icons.autorenew,
                  color: AppColors.kWhiteColor),
            )
          ],
        ),
      ),
    );
  }
}
