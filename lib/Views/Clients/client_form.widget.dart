import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:tax_payment_app/Resources/Components/button.dart';
import 'package:tax_payment_app/Resources/Components/text_fields.dart';
import 'package:tax_payment_app/Resources/Constants/enums.dart';
import 'package:tax_payment_app/Resources/Constants/global_variables.dart';
import 'package:tax_payment_app/Resources/Models/partner.model.dart';
import 'package:tax_payment_app/Resources/Providers/client.provider.dart';

class ClientFormWidget extends StatefulWidget {
  TextEditingController fullnameCtrller = TextEditingController(),
      phoneCtrller = TextEditingController(),
      emailCtrller = TextEditingController(),
      nationalIDCtrller = TextEditingController(),
      impotIDCtrller = TextEditingController(),
      bpCtrller = TextEditingController();
  bool canSave;
  ClientFormWidget({Key? key, this.canSave = false}) : super(key: key);

  @override
  State<ClientFormWidget> createState() => _ClientFormWidgetState();
}

class _ClientFormWidgetState extends State<ClientFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      child: Column(
        children: [
          TextFormFieldWidget(
              editCtrller: widget.fullnameCtrller,
              hintText: "Nom complet",
              textColor: AppColors.kWhiteColor,
              backColor: AppColors.kTextFormWhiteColor),
          TextFormFieldWidget(
            editCtrller: widget.phoneCtrller,
            hintText: "No phone",
            textColor: AppColors.kWhiteColor,
            backColor: AppColors.kTextFormWhiteColor,
            inputType: TextInputType.phone,
          ),
          TextFormFieldWidget(
            editCtrller: widget.emailCtrller,
            hintText: "E-mail",
            textColor: AppColors.kWhiteColor,
            backColor: AppColors.kTextFormWhiteColor,
            inputType: TextInputType.emailAddress,
          ),
          TextFormFieldWidget(
            editCtrller: widget.nationalIDCtrller,
            hintText: "ID Nat",
            textColor: AppColors.kWhiteColor,
            backColor: AppColors.kTextFormWhiteColor,
          ),
          TextFormFieldWidget(
              editCtrller: widget.impotIDCtrller,
              hintText: "No impot",
              textColor: AppColors.kWhiteColor,
              backColor: AppColors.kTextFormWhiteColor),
          TextFormFieldWidget(
              editCtrller: widget.bpCtrller,
              hintText: "B.P",
              textColor: AppColors.kWhiteColor,
              backColor: AppColors.kTextFormWhiteColor),
          const SizedBox(height: 24),
          if (widget.canSave == true)
            CustomButton(
                text: 'Enregister',
                backColor: AppColors.kScaffoldColor,
                textColor: AppColors.kWhiteColor,
                callback: () {
                  if (widget.fullnameCtrller.text.isEmpty ||
                      widget.phoneCtrller.text.isEmpty) {
                    ToastNotification.showToast(
                        msg: "Veuillez remplir toutes les données du client",
                        msgType: MessageType.error,
                        title: "Erreur");
                    return;
                  }
                  if (!widget.phoneCtrller.text.contains('+')) {
                    ToastNotification.showToast(
                        msg:
                            "Veuillez saisir le numéro de téléphone avec le code pays",
                        msgType: MessageType.error,
                        title: "Erreur");
                    return;
                  }
                  if (context
                      .read<ClientProvider>()
                      .offlineData
                      .where((item) => item.phone.contains(widget
                          .phoneCtrller.text
                          .trim()
                          .replaceAll(' ', '')
                          .replaceAll('+', '')))
                      .toList()
                      .isNotEmpty) {
                    ToastNotification.showToast(
                        msg: "Ce numéro de téléphone déjà utilisé",
                        msgType: MessageType.error,
                        title: "Erreur");
                    return;
                  }
                  ClientModel data = ClientModel.fromJSON({
                    "fullname": widget.fullnameCtrller.text.trim(),
                    "phone": widget.phoneCtrller.text.trim(),
                    "email": widget.emailCtrller.text.trim(),
                    "nationalID": widget.nationalIDCtrller.text.trim(),
                    "impotID": widget.impotIDCtrller.text.trim(),
                    "syncStatus": 0,
                    "postalCode": widget.bpCtrller.text.trim(),
                  });
                  context.read<ClientProvider>().saveData(
                      data: data,
                      callback: () {
                        Navigator.pop(context);
                      });
                })
        ],
      ),
    ));
  }
}
