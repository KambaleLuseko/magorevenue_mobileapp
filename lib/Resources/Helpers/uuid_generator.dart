import 'package:provider/src/provider.dart';

uuidGenerator() {
  return DateTime.now()
      .toString()
      .replaceAll("-", "")
      .replaceAll(":", "")
      .replaceAll(" ", "")
      .replaceAll(".", "");
  // -${navKey.currentContext!.read<UserProvider>().userLogged?.user.id}
}
