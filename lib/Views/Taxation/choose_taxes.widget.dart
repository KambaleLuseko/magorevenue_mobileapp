import 'package:flutter/material.dart';
import 'package:tax_payment_app/Resources/Components/list_item.dart';
import 'package:tax_payment_app/Resources/Components/texts.dart';
import 'package:tax_payment_app/Resources/Constants/global_variables.dart';
import 'package:tax_payment_app/Resources/Helpers/uuid_generator.dart';
import 'package:tax_payment_app/Resources/Models/Menu/list_item.model.dart';
import 'package:tax_payment_app/Resources/Models/division.model.dart';

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
                    onTap: () {
                      if (!widget.choosedData!
                          .map((e) => e.taxe_uuid)
                          .contains(widget.data[index].uuid)) {
                        widget.choosedData!.add(TaxePaymentModel(
                            taxe_uuid: widget.data[index].uuid!,
                            taxation_uuid: widget.transactionUUID,
                            taxName: widget.data[index].name,
                            taxDescription: widget.data[index].description,
                            amount:
                                "${(double.parse(widget.data[index].montant_du) * double.parse(widget.data[index].pourcentage)) / 100}",
                            dueDate: DateTime.now()
                                .add(const Duration(days: 30))
                                .toString(),
                            status: "Pending"));
                      } else {
                        widget.choosedData!.removeWhere((element) =>
                            element.taxe_uuid == widget.data[index].uuid);
                      }
                      // print('set');
                      setState(() {});
                    },
                    child: Card(
                      margin: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                      color: AppColors.kAccentColor,
                      elevation: widget.choosedData!
                              .map((e) => e.taxe_uuid)
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
                              .map((e) => e.taxe_uuid)
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
