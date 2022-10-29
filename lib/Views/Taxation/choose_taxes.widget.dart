import 'package:flutter/material.dart';
import 'package:tax_payment_app/Resources/Components/dialogs.dart';
import 'package:tax_payment_app/Resources/Components/text_fields.dart';
import 'package:tax_payment_app/Resources/Components/texts.dart';
import 'package:tax_payment_app/Resources/Constants/enums.dart';
import 'package:tax_payment_app/Resources/Constants/global_variables.dart';
import 'package:tax_payment_app/Resources/Helpers/uuid_generator.dart';
import 'package:tax_payment_app/Resources/Models/division.model.dart';
import 'package:collection/collection.dart';

class ChooseClientTaxesWidget extends StatefulWidget {
  String transactionUUID;
  List<TaxeModel> data;
  List<TaxePaymentModel>? choosedData = [];
  ChooseClientTaxesWidget(
      {Key? key, required this.data, required this.transactionUUID})
      : super(key: key);

  @override
  State<ChooseClientTaxesWidget> createState() =>
      _ChooseClientTaxesWidgetState();
}

class _ChooseClientTaxesWidgetState extends State<ChooseClientTaxesWidget> {
  List<TextEditingController> _inputCtrller = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
    //   for (var i = 0; i < widget.data; i++) {

    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          ...List.generate(
              widget.data.length,
              (index) => GestureDetector(
                    onTap: () async {
                      List<TextEditingController> inputsCtrller = widget
                          .data[index].inputs
                          .map((e) => TextEditingController(
                              text: widget.choosedData!
                                      .firstWhereOrNull((element) =>
                                          element.taxe_id.toString() ==
                                              widget.data[index].id
                                                  .toString() ||
                                          element.taxe_id ==
                                              widget.data[index].uuid)
                                      ?.inputsData
                                      ?.firstWhere((element) =>
                                          element['name'] == e.name)['value'] ??
                                  ''))
                          .toList();
                      List<TaxeInputModel> taxeInputs =
                          widget.data[index].inputs.map((e) => e).toList();
                      // print(widget.data[index].inputs);
                      String uuid = uuidGenerator();
                      await Dialogs.showDialogWithActionCustomContent(
                          title: 'Informations supplémentaires',
                          callback: () {
                            bool hasErrors = false;
                            List otherData = [];
                            for (var i = 0; i < inputsCtrller.length; i++) {
                              if (inputsCtrller[i].text.isEmpty) {
                                hasErrors = true;
                              } else {
                                otherData.add({
                                  "taxe_id": uuid,
                                  "name": taxeInputs[i].name,
                                  "value": inputsCtrller[i].text.trim()
                                });
                              }
                            }
                            if (hasErrors) {
                              ToastNotification.showToast(
                                  msg: 'Certains champs sont vides',
                                  msgType: MessageType.error,
                                  title: "Erreur");
                              return;
                            }
                            TaxePaymentModel? checkExists = widget.choosedData!
                                .firstWhereOrNull((element) =>
                                    element.taxe_id.toString() ==
                                        widget.data[index].id.toString() ||
                                    element.taxe_id == widget.data[index].uuid);
                            if (checkExists != null) {
                              widget.choosedData!
                                  .firstWhere((element) =>
                                      element.taxe_id ==
                                          widget.data[index].id.toString() ||
                                      element.taxe_id ==
                                          widget.data[index].uuid)
                                  .inputsData = otherData;
                              setState(() {});
                              return;
                            }
                            widget.choosedData!.add(TaxePaymentModel(
                                uuid: uuid,
                                recoveryDate: DateTime.now()
                                    .add(const Duration(days: 15))
                                    .toString(),
                                inputsData: otherData,
                                taxe_id: widget.data[index].uuid!,
                                taxation_uuid: widget.transactionUUID,
                                taxName: widget.data[index].name,
                                taxDescription: widget.data[index].description,
                                amountPaid:
                                    "${(double.parse(widget.data[index].montant_du) * double.parse(widget.data[index].pourcentage)) / 100}",
                                nextPayment: DateTime.now()
                                    .add(const Duration(days: 30))
                                    .toString(),
                                status: "Pending"));
                            setState(() {});
                          },
                          content: Column(
                            children: [
                              ...List.generate(widget.data[index].inputs.length,
                                  (inputIndex) {
                                return TextFormFieldWidget(
                                    editCtrller: inputsCtrller[inputIndex],
                                    inputType: widget.data[index]
                                                .inputs[inputIndex].type ==
                                            'date'
                                        ? TextInputType.datetime
                                        : widget.data[index].inputs[inputIndex]
                                                    .type ==
                                                'number'
                                            ? TextInputType.number
                                            : widget
                                                        .data[index]
                                                        .inputs[inputIndex]
                                                        .type ==
                                                    'phone'
                                                ? TextInputType.phone
                                                : TextInputType.text,
                                    hintText: widget
                                        .data[index].inputs[inputIndex].name,
                                    textColor: AppColors.kWhiteColor,
                                    backColor: AppColors.kTextFormWhiteColor);
                              })
                            ],
                          ));
                      return;
                      if (!widget.choosedData!
                          .map((e) => e.taxe_id)
                          .contains(widget.data[index].uuid)) {
                        widget.choosedData!.add(TaxePaymentModel(
                            recoveryDate: '',
                            taxe_id: widget.data[index].uuid!,
                            taxation_uuid: widget.transactionUUID,
                            taxName: widget.data[index].name,
                            taxDescription: widget.data[index].description,
                            amountPaid:
                                "${(double.parse(widget.data[index].montant_du) * double.parse(widget.data[index].pourcentage)) / 100}",
                            nextPayment: DateTime.now()
                                .add(const Duration(days: 30))
                                .toString(),
                            status: "Pending"));
                      } else {
                        widget.choosedData!.removeWhere((element) =>
                            element.taxe_id == widget.data[index].uuid);
                      }
                      // print('set');
                      setState(() {});
                    },
                    child: Card(
                      margin: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                      color: AppColors.kAccentColor,
                      elevation: widget.choosedData!
                              .map((e) => e.taxe_id)
                              .contains(widget.data[index].uuid)
                          ? 5
                          : 5,
                      // shadowColor: AppColors.kTextFormWhiteColor,
                      child: Stack(
                        overflow: Overflow.visible,
                        children: [
                          ListTile(
                            title: TextWidgets.textBold(
                                title: widget.data[index].name,
                                fontSize: 14,
                                textColor: AppColors.kWhiteColor),
                            subtitle: TextWidgets.text300(
                                title: widget.data[index].description ?? '',
                                fontSize: 12,
                                textColor: AppColors.kWhiteColor),
                            trailing: TextWidgets.text300(
                                title:
                                    "CDF ${(double.parse(widget.data[index].montant_du) * double.parse(widget.data[index].pourcentage)) / 100}",
                                fontSize: 14,
                                textColor: AppColors.kWhiteColor),
                          ),
                          if (widget.choosedData!
                              .map((e) => e.taxe_id)
                              .contains(widget.data[index].uuid))
                            Positioned(
                                top: -10,
                                right: 0,
                                child: Icon(Icons.check_circle_sharp,
                                    color: AppColors.kWhiteColor))
                        ],
                      ),
                    ),
                  ))
        ],
      ),
    ));
  }
}
