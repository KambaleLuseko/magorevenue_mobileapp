import '../../Resources/Helpers/LocalData/local_data.helper.dart';

class SyncOnlineLocalHelper {
  static insertNewDataOffline(
      {required List onlineData,
      required List offlineData,
      required String key,
      bool? mustClearLocalData = true,
      Function? callback}) async {
    // offlineData.clear();
    // await LocalDataHelper.clearLocalData(key: key);
    // if (onlineData.isNotEmpty && mustClearLocalData == true) {
    await LocalDataHelper.clearLocalData(key: key);
    offlineData.clear();
    // }
    // print('inserting new data');
    // if (key.toLowerCase() == 'samples') {}
    List missedOnlineData = [];
    List offlineUUID =
        offlineData.map((e) => e['uuid'].toString().trim()).toList();
    // print(onlineData);
    // print(offlineData);
    if (offlineData.isNotEmpty && onlineData.isNotEmpty) {
      for (int i = 0; i < onlineData.length; i++) {
        if (!offlineUUID.contains(onlineData[i]['uuid'].toString().trim()) ||
            offlineData
                .where((element) =>
                    element['uuid'].toString().trim().toLowerCase() ==
                        onlineData[i]['uuid'].toString().trim().toLowerCase() &&
                    element['syncStatus'].toString() == '1')
                .toList()
                .isNotEmpty) {
          missedOnlineData.add(onlineData[i]);
        }
      }
      for (int i = 0; i < missedOnlineData.length; i++) {
        // print(missedOnlineData[i]);
        await LocalDataHelper.saveData(value: missedOnlineData[i], key: key);
      }
    } else {
      for (int i = 0; i < onlineData.length; i++) {
        // print('online');
        // print(onlineData[i]);
        await LocalDataHelper.saveData(value: onlineData[i], key: key);
      }
    }
    if (callback != null) {
      callback();
    }
  }

  // static insertEmbededNewDataOffline(
  //     {required List onlineData,
  //     required List offlineData,
  //     required String key}) async {
  //   if (key.toLowerCase() == 'samples') {
  //     List missedOnlineData = [];
  //     List offlineUUID =
  //         offlineData.map((e) => e['uuid'].toString().trim()).toList();
  //     // print(onlineData);
  //     // print(offlineData);
  //     if (offlineData.isNotEmpty && onlineData.isNotEmpty) {
  //       for (int i = 0; i < onlineData.length; i++) {
  //         if (!offlineUUID.contains(onlineData[i]['uuid'].toString().trim())) {
  //           missedOnlineData.add(onlineData[i]);
  //         }
  //       }
  //       for (int i = 0; i < missedOnlineData.length; i++) {
  //         await LocalDataHelper.saveData(value: missedOnlineData[i], key: key);
  //       }
  //     } else {
  //       for (int i = 0; i < onlineData.length; i++) {
  //         await LocalDataHelper.saveData(value: onlineData[i], key: key);
  //       }
  //     }
  //   }
  // }
}
