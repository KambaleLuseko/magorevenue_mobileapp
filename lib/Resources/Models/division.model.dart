import 'dart:convert';

import 'package:tax_payment_app/Resources/Helpers/uuid_generator.dart';

class DivisionModel {
  int? id, active, syncStatus;
  String name;
  String? uuid, description;
  List<TaxeModel>? taxes;
  DivisionModel(
      {this.uuid,
      required this.name,
      this.description,
      this.id,
      this.active,
      this.syncStatus,
      this.taxes = const []});

  static fromJSON(json) {
    List data = json['taxes'] is String
        ? jsonDecode(json['taxes'] ?? [])
        : json['taxes'];
    List<TaxeModel> taxes = data is List<TaxeModel>
        ? data
        : data != null
            ? List<TaxeModel>.from(data.map((item) {
                return TaxeModel.fromJSON(item);
              }))
            : [];
    return DivisionModel(
        name: json['name'],
        description: json['description'],
        uuid: json['uuid'],
        id: json['id'],
        active: json['active'],
        syncStatus: json['syncStatus'] ?? 0,
        taxes: taxes);
  }

  toJSON() {
    return {
      "name": name,
      "description": description,
      "uuid": uuid ?? uuidGenerator(),
      'taxes': jsonEncode(taxes?.map((e) => e.toJSON()).toList()),
      "id": id,
      "active": active,
      "syncStatus": syncStatus,
    };
  }
}

class TaxeModel {
  String? uuid, description;
  int? id, active, syncStatus;
  String divisionUuid, name, montant_du, pourcentage;
  TaxeModel(
      {required this.divisionUuid,
      required this.name,
      required this.montant_du,
      required this.pourcentage,
      this.uuid,
      this.description,
      this.id,
      this.active,
      this.syncStatus});

  static fromJSON(json) {
    return TaxeModel(
      id: json['id'],
      uuid: json['uuid'] ?? uuidGenerator(),
      divisionUuid: json['division_uuid'],
      name: json['name'],
      description: json['description'],
      montant_du: json['montant_du'],
      pourcentage: json['pourcentage'],
      active: json['active'],
      syncStatus: json['syncStatus'] ?? 0,
    );
  }

  toJSON() {
    return {
      "division_uuid": divisionUuid,
      "name": name,
      "montant_du": montant_du,
      "pourcentage": pourcentage,
      "description": description,
      "uuid": uuid ?? uuidGenerator(),
      "id": id,
      "active": active,
      "syncStatus": syncStatus,
    };
  }
}

class TaxePaymentModel {
  String? uuid, taxDescription, taxName;
  int? id, syncStatus;
  String taxe_uuid, taxation_uuid, amount, dueDate, status;
  TaxePaymentModel(
      {required this.taxe_uuid,
      required this.taxation_uuid,
      this.taxName,
      required this.amount,
      required this.dueDate,
      this.uuid,
      this.taxDescription,
      this.id,
      required this.status,
      this.syncStatus});

  static fromJSON(json) {
    return TaxePaymentModel(
      id: json['id'],
      uuid: json['uuid'] ?? uuidGenerator(),
      taxName: json['taxName'],
      taxe_uuid: json['taxe_uuid'],
      taxation_uuid: json['taxation_uuid'],
      taxDescription: json['taxDescription'],
      amount: json['amount'],
      dueDate: json['dueDate'],
      status: json['status']?.toString() ?? '',
      syncStatus: json['syncStatus'] ?? 0,
    );
  }

  toJSON() {
    return {
      "taxe_uuid": taxe_uuid,
      "taxation_uuid": taxation_uuid,
      "taxName": taxName,
      "taxDescription": taxDescription,
      "amount": amount,
      "dueDate": dueDate != 'null'
          ? dueDate
          : DateTime.now().add(const Duration(days: 30)).toString(),
      "uuid": uuid ?? uuidGenerator(),
      "id": id,
      "status": status,
      "syncStatus": syncStatus,
    };
  }
}
