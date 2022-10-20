// import '../../Resources/Helpers/uuid_generator.dart';

import 'package:tax_payment_app/Resources/Helpers/uuid_generator.dart';

class ClientModel {
  int? id;
  final String fullname, phone;
  final String? nationalID, impotID, postalCode, uuid, email;
  int? syncStatus, isActive;

  ClientModel(
      {this.uuid,
      required this.fullname,
      required this.phone,
      this.email,
      this.id,
      this.nationalID,
      this.impotID,
      this.postalCode,
      this.isActive,
      this.syncStatus});

  static fromJSON(json) {
    return ClientModel(
      uuid: json['uuid']?.toString(),
      fullname: json['fullname'] ?? '',
      phone: json['phone'] ?? '',
      id: int.tryParse(json['id'].toString()) ?? 0,
      email: json['email']?.toString(),
      nationalID: json['nationalID']?.toString(),
      impotID: json['impotID']?.toString(),
      postalCode: json['postalCode']?.toString(),
      isActive: int.tryParse(json['isActive'].toString()) ?? 1,
      syncStatus: int.tryParse(json['syncStatus'].toString()) ?? 0,
    );
  }

  toJSON() {
    return {
      "uuid": uuid ?? uuidGenerator(),
      "fullname": fullname,
      "phone": phone,
      "id": id,
      "email": email,
      "nationalID": nationalID,
      "impotID": impotID,
      "isActive": isActive,
      "syncStatus": syncStatus,
      "postalCode": postalCode
    };
  }
}
