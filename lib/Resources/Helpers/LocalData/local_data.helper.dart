import 'dart:convert';

import 'package:tax_payment_app/main.dart';
import 'package:hive/hive.dart';
import '../../../Resources/Constants/enums.dart';
import '../../../Resources/Models/pagination.model.dart';

class LocalDataHelper {
  static resetLocalData() async {
    for (int i = 0; i < storeNames.length; i++) {
      Box store = await Hive.openBox(storeNames[i]);
      await store.clear();
    }
  }

  static clearLocalData({required String key}) async {
    Box store = await Hive.openBox(key);
    await store.clear();
  }

  static saveData(
      {required Map value,
      required String key,
      EnumActions? action = EnumActions.SAVE}) async {
    storeData(data: value, key: key);
  }

  static saveMultiple({required List values, required String key}) async {
    var store = await Hive.openBox(key);
    // List storedData = store.values.toList();
    for (int i = 0; i < values.length; i++) {
      await storeData(data: values[i], key: key);
    }
    // await txn.completed;
    // getData(key: key);
  }

  static updateData({required Map value, required String key}) async {
    // var txn = dba!.transaction(key, 'readwrite');
    // var store = txn.objectStore(key);
    // await store.put(value);
    // // print(keySaved);
    // await txn.completed;
  }

  static getData(
      {required String key,
      String? column,
      String? value,
      PaginationModel? pagination}) async {
    Box store = await Hive.openBox(key);
    List values = store.values.toList();
    values = List.from(values.map((e) => jsonDecode(e)).toList());
    // print(values);
    // await txn.completed;
    // if (pagination != null) {
    //   int start = (pagination.page - 1) * pagination.limit;
    //   int end = pagination.page * pagination.limit;
    //   // print(start);
    //   // print(end);
    //   if (end <= values.length) {
    //     return values.sublist(start, end);
    //   }
    //   return [];
    //   // return values.length > end ? values.sublist(start, end) : values;
    // }
    return values.reversed.toList();
    // return values.length > 10 ? values.sublist(0, 10) : values;
  }

  static Future storeData({required Map data, required String key}) async {
    Box store = await Hive.openBox(key);
    await store.put(
        (data['uuid'] ?? data['id'] ?? DateTime.now().toString()).toString(),
        jsonEncode(data));
  }
}
