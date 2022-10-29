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
  List<TaxeInputModel> inputs;
  TaxeModel(
      {required this.divisionUuid,
      required this.name,
      required this.montant_du,
      required this.pourcentage,
      this.uuid,
      this.description,
      this.id,
      this.active,
      this.syncStatus,
      required this.inputs});

  static fromJSON(json) {
    // print(json['inputs'] is List<TaxeInputModel>
    //     ? json['inputs']
    //     : json['inputs'] != null
    //         ? List<TaxeInputModel>.from(json['inputs'].map((item) {
    //             return TaxeInputModel.fromJSON(item);
    //           }))
    //         : []);
    return TaxeModel(
        id: json['id'],
        uuid: json['uuid'] ?? uuidGenerator(),
        divisionUuid: json['division_uuid'],
        name: json['name'],
        description: json['description'],
        montant_du: json['montant_du'],
        pourcentage: json['pourcentageAPayer'],
        active: json['active'],
        syncStatus: json['syncStatus'] ?? 0,
        inputs: json['inputs'] is List<TaxeInputModel>
            ? json['inputs']
            : json['inputs'] != null
                ? List<TaxeInputModel>.from(json['inputs'].map((item) {
                    return TaxeInputModel.fromJSON(item);
                  }))
                : []);
  }

  toJSON() {
    return {
      "division_uuid": divisionUuid,
      "name": name,
      "montant_du": montant_du,
      "pourcentageAPayer": pourcentage,
      "description": description,
      "uuid": uuid ?? uuidGenerator(),
      "id": id,
      "active": active,
      "syncStatus": syncStatus,
      "inputs": inputs.map((e) => e.toJSON()).toList(),
    };
  }
}

class TaxeInputModel {
  int taxe_id;
  int? id, syncStatus, isRequired;
  String name;
  String? type;
  TaxeInputModel(
      {required this.taxe_id,
      required this.name,
      this.type,
      this.isRequired,
      this.id,
      this.syncStatus});

  static fromJSON(json) {
    return TaxeInputModel(
      id: json['id'],
      taxe_id: json['taxe_id'],
      name: json['name'],
      type: json['type'],
      isRequired: json['required'],
      syncStatus: json['syncStatus'] ?? 0,
    );
  }

  toJSON() {
    return {
      "taxe_id": taxe_id,
      "name": name,
      "type": type,
      "required": isRequired,
      "id": id,
      "syncStatus": syncStatus,
    };
  }
}

class TaxePaymentModel {
  String? uuid, taxDescription, taxName;
  int? id, syncStatus;
  String taxe_id, taxation_uuid, amountPaid, nextPayment, recoveryDate, status;
  List? inputsData, taxeInfo;
  TaxePaymentModel(
      {required this.taxe_id,
      required this.taxation_uuid,
      this.taxName,
      required this.amountPaid,
      required this.nextPayment,
      required this.recoveryDate,
      this.uuid,
      this.taxDescription,
      this.id,
      required this.status,
      this.syncStatus,
      this.inputsData,
      this.taxeInfo});

  static fromJSON(json) {
    return TaxePaymentModel(
      id: json['id'],
      uuid: json['uuid'] ?? uuidGenerator(),
      taxName: json['taxName'],
      taxe_id: json['taxe_id'],
      taxation_uuid: json['taxation_uuid'],
      taxDescription: json['taxDescription'],
      amountPaid: json['amountPaid'],
      nextPayment: json['nextPayment'],
      recoveryDate: json['recoveryDate'],
      status: json['status']?.toString() ?? '',
      syncStatus: json['syncStatus'] ?? 0,
      inputsData: json['inputsData'] ?? [],
      taxeInfo: json['taxeInfo'] ?? [],
    );
  }

  toJSON() {
    return {
      "taxe_id": taxe_id,
      "taxation_uuid": taxation_uuid,
      "taxName": taxName,
      "taxDescription": taxDescription,
      "amountPaid": amountPaid,
      "recoveryDate": recoveryDate,
      "nextPayment": nextPayment != 'null'
          ? nextPayment
          : DateTime.now().add(const Duration(days: 30)).toString(),
      "uuid": uuid ?? uuidGenerator(),
      "id": id,
      "status": status,
      "syncStatus": syncStatus,
      "inputsData": inputsData,
      "taxeInfo": taxeInfo
    };
  }
}
