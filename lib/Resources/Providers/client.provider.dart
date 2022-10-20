import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tax_payment_app/Resources/Constants/app_providers.dart';
import 'package:tax_payment_app/Resources/Constants/enums.dart';
import 'package:tax_payment_app/Resources/Constants/global_variables.dart';
import 'package:tax_payment_app/Resources/Helpers/LocalData/local_data.helper.dart';
import 'package:tax_payment_app/Resources/Helpers/sync_online_local.dart';
import 'package:tax_payment_app/Resources/Models/partner.model.dart';

class ClientProvider extends ChangeNotifier {
  String keyName = 'clients';
  List<ClientModel> dataList = [], offlineData = [];

  saveData(
      {required ClientModel data,
      EnumActions? action = EnumActions.SAVE,
      required Function callback}) async {
    if (action == EnumActions.UPDATE && data.uuid == null) {
      ToastNotification.showToast(
          msg: "Données invalides", msgType: MessageType.error, title: "Error");
      return;
    }
    Response res;
    if (action == EnumActions.UPDATE) {
      res = await AppProviders.appProvider
          .httpPut(url: "${BaseUrl.clients}${data.uuid}", body: data.toJSON());
    } else {
      res = await AppProviders.appProvider
          .httpPost(url: BaseUrl.clients, body: data.toJSON());
    }
    // print(res.body);
    if (res.statusCode == 200) {
      data.syncStatus = 1;
      LocalDataHelper.saveData(key: keyName, value: data.toJSON());
      ToastNotification.showToast(
          msg: jsonDecode(res.body)['message'] ??
              "Informations sauvegardées avec succès",
          msgType: MessageType.success,
          title: "Success");
    }
    if (res.statusCode == 500) {
      LocalDataHelper.saveData(key: keyName, value: data.toJSON());
      ToastNotification.showToast(
          msg: jsonDecode(res.body)['message'] ??
              'Une erreur est survenue, sauvegarde hors connexion en cours...',
          msgType: MessageType.info,
          title: "Information");
    }
    if (res.statusCode != 200 && res.statusCode != 500) {
      ToastNotification.showToast(
          msg: jsonDecode(res.body)['message'] ??
              'Une erreur est survenue, Veuillez réessayer',
          msgType: MessageType.error,
          title: "Erreur");
      return;
    }
    getOffline(isRefresh: true);
    notifyListeners();
    callback();
    // getOffline(isRefresh: true);
  }

  get({bool? isRefresh = false}) {
    if (AppProviders.appProvider.isApiReachable) {
      getOnline(isRefresh: isRefresh);
    }
    getOffline(isRefresh: isRefresh);
  }

  getOffline({bool? isRefresh = false}) async {
    if (isRefresh == false && offlineData.isNotEmpty) return;
    List data = await LocalDataHelper.getData(
      key: keyName,
    );
    offlineData = List<ClientModel>.from(
        data.map((item) => ClientModel.fromJSON(item)).toList());
    notifyListeners();
  }

  getOnline({bool? isRefresh = false, String? value}) async {
    if (isRefresh == false && offlineData.isNotEmpty) return;
    var response = await AppProviders.appProvider
        .httpGet(url: "${BaseUrl.clients}${value ?? ''}");
    List data = [];
    // print(response.body);
    if (response.statusCode == 200) {
      data = jsonDecode(response.body)['data'];
    }
    dataList = List<ClientModel>.from(
        data.map((item) => ClientModel.fromJSON(item)).toList());
    SyncOnlineLocalHelper.insertNewDataOffline(
        onlineData: dataList.map((e) => e.toJSON()).toList(),
        offlineData: offlineData.map((e) => e.toJSON()).toList(),
        key: keyName,
        callback: getOffline);
    notifyListeners();
  }

  reset() {
    offlineData.clear();
    dataList.clear();
  }

  List<ClientModel> dataToSync = [];
  syncOfflineData({bool? clearLocalData = false}) async {
    if (dataToSync.isEmpty) return;
    Response response = await AppProviders.appProvider.httpPost(
        url: "${BaseUrl.clients}sync",
        body: {"data": dataToSync.map((e) => e.toJSON()).toList()});
    // print(response.body);
    if (response.statusCode == 200) {
      ToastNotification.showToast(
          msg: "Synchronisation des données terminés",
          msgType: MessageType.info,
          title: "Information");
      // if (clearLocalData == true) LocalDataHelper.clearLocalData(key: keyName);
      getOnline(isRefresh: true);
      return;
    }
    ToastNotification.showToast(
        msg: jsonDecode(response.body)['message'] ??
            "Une erreur est survenue lors de la synchronisation des données",
        msgType: MessageType.error,
        title: "Erreur");
  }

  List<ClientModel> getDataToSync() {
    getOffline(isRefresh: true);
    dataToSync =
        offlineData.where((element) => element.syncStatus == 0).toList();
    // print(offlineData.map((e) => e.toJSON()).toList());
    return dataToSync;
  }
}
