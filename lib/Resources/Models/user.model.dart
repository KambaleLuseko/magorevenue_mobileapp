// import '../../Resources/Helpers/uuid_generator.dart';
import '../../Resources/Models/user_permission.model.dart';

class UserModel {
  final String fullname, phone, username, password, level;
  final String? email, address, uuid;
  int? syncStatus, isActive, id;
  List? permissions;

  UserModel(
      {required this.fullname,
      required this.phone,
      required this.username,
      required this.password,
      required this.level,
      this.email,
      this.address,
      this.isActive,
      this.syncStatus,
      this.uuid,
      this.id,
      this.permissions});

  static fromJSON(json) {
    return UserModel(
        fullname: json['fullname'],
        phone: json['phone'],
        username: json['username'],
        password: json['password'],
        level: json['level'] ?? '',
        email: json['email'],
        address: json['address'],
        isActive: int.tryParse(json['isActive'].toString()) ?? 1,
        syncStatus: int.tryParse(json['syncStatus'].toString()) ?? 0,
        // uuid: json['uuid'] ?? uuidGenerator(),
        id: int.tryParse(json['id'].toString()) ?? 0,
        permissions: json['permissions'] is List<UserPermissionModel>
            ? json['permissions']
            : json['permissions'] != null
                ? List<UserPermissionModel>.from(json['permissions'].map(
                    (item) => UserPermissionModel(
                        uuid: item['uuid'],
                        user_uuid: json['uuid'],
                        permission_uuid: item['permission_uuid'],
                        create: item['create'],
                        read: item['read'],
                        update: item['update'],
                        delete: item['delete'])))
                : []);
  }

  toJSON() {
    return {
      "fullname": fullname,
      "phone": phone,
      "username": username,
      "password": password,
      "level": level,
      "email": email,
      "address": address,
      "isActive": isActive,
      "syncStatus": syncStatus,
      "uuid": uuid,
      "id": id
    };
  }
}

class AuthModel {
  final UserModel user;
  final String token;
  AuthModel({required this.user, required this.token});

  static fromJSON(json) {
    return AuthModel(
        user: UserModel.fromJSON(json['user']), token: json['token']);
  }

  toJSON() {
    return {"user": user.toJSON(), 'token': token};
  }
}
