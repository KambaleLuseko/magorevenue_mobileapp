class UserPermissionModel {
  final String user_uuid, permission_uuid;
  int? create, read, update, delete;
  final String? uuid;

  UserPermissionModel(
      {required this.user_uuid,
      required this.permission_uuid,
      this.create,
      this.read,
      this.update,
      this.delete,
      this.uuid});

  toJSON() {
    return {
      "uuid": uuid ??
          DateTime.now()
              .toString()
              .replaceAll("-", "")
              .replaceAll(":", "")
              .replaceAll(" ", "")
              .replaceAll(".", ""),
      "user_uuid": user_uuid,
      "permission_uuid": permission_uuid,
      "create": create,
      "read": read,
      "update": update,
      "delete": delete,
    };
  }
}
