import 'package:tax_payment_app/Resources/Helpers/uuid_generator.dart';
import 'package:tax_payment_app/Resources/Models/division.model.dart';
import 'package:tax_payment_app/Resources/Models/partner.model.dart';

class TaxationModel {
  int? id, syncStatus, active;
  String? uuid, createdAt, status, taxName, taxDescription;
  String client_uuid, amount;
  ClientModel? client;
  List<TaxePaymentModel>? taxes;
  TaxationModel(
      {required this.client_uuid,
      required this.amount,
      this.status,
      this.id,
      this.uuid,
      this.syncStatus,
      this.active,
      this.taxName,
      this.taxDescription,
      this.client,
      this.taxes,
      this.createdAt});

  static fromJSON(json) {
    return TaxationModel(
        client_uuid: json['client_uuid'],
        amount: json['amount']?.toString() ?? '0',
        status: json['status'],
        id: json['id'],
        uuid: json['uuid'],
        syncStatus: json['syncStatus'],
        active: json['active'],
        taxName: json['taxName'],
        taxDescription: json['taxDescription'],
        client: json['client'] is ClientModel
            ? json['client']
            : json['client'] != null
                ? ClientModel.fromJSON(json['client'])
                : null,
        taxes: json['taxes'] is List<TaxePaymentModel>
            ? json['taxes']
            : json['taxes'] != null
                ? List<TaxePaymentModel>.from(json['taxes']
                    .map((item) => TaxePaymentModel.fromJSON(item)))
                : [],
        createdAt: json['createdAt'] ?? '0000-00-00');
  }

  toJSON() {
    return {
      "id": id,
      "uuid": uuid ?? uuidGenerator(),
      "client_uuid": client_uuid,
      "amount": amount,
      "status": status ?? "Constatation",
      "syncStatus": syncStatus ?? 0,
      "createdAt": createdAt ?? DateTime.now().toString(),
      "client": client?.toJSON(),
      "taxes": taxes?.map((e) => e.toJSON()).toList()
    };
  }
}
