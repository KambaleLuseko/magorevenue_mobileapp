import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tax_payment_app/Resources/Constants/app_providers.dart';
import 'package:tax_payment_app/Resources/Constants/enums.dart';
import 'package:tax_payment_app/Resources/Constants/global_variables.dart';
import 'package:tax_payment_app/Resources/Helpers/LocalData/local_data.helper.dart';
import 'package:tax_payment_app/Resources/Helpers/sync_online_local.dart';
import 'package:tax_payment_app/Resources/Models/division.model.dart';
import 'package:tax_payment_app/Resources/Models/taxation.mode.dart';

class TaxationProvider extends ChangeNotifier {
  String keyName = 'taxation';
  List<TaxationModel> dataList = [], offlineData = [], homeData = [];
  saveData(
      {required Map data,
      EnumActions? action = EnumActions.SAVE,
      required Function callback}) async {
    if (action == EnumActions.UPDATE && data['id'] == null) {
      ToastNotification.showToast(
          msg: "Données invalides", msgType: MessageType.error, title: "Error");
      return;
    }
    Response res;
    if (action == EnumActions.UPDATE) {
      res = await AppProviders.appProvider
          .httpPut(url: "${BaseUrl.taxations}${data['uuid']}", body: data);
    } else {
      res = await AppProviders.appProvider
          .httpPost(url: BaseUrl.taxations, body: data);
    }
    if (res.statusCode == 200) {
      data['syncStatus'] = 1;
      LocalDataHelper.saveData(key: keyName, value: data);
      ToastNotification.showToast(
          msg: jsonDecode(res.body)['message'] ??
              "Informations sauvegardées avec succès",
          msgType: MessageType.success,
          title: "Success");
    }
    if (res.statusCode == 500) {
      LocalDataHelper.saveData(key: keyName, value: data);
      ToastNotification.showToast(
          msg: 'Une erreur est survenue, sauvegarde hors connexion en cours...',
          msgType: MessageType.info,
          title: "Information");
    }
    if (res.statusCode != 200 && res.statusCode != 500) {
      ToastNotification.showToast(
          msg: jsonDecode(res.body)['message'] ??
              'Une erreur est survenue, Veuillez réessayer',
          msgType: MessageType.error,
          title: "Erreur");
    }
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
    offlineData = List<TaxationModel>.from(
        data.map((item) => TaxationModel.fromJSON(item)).toList());
    homeData =
        offlineData.length > 20 ? offlineData.sublist(0, 20) : offlineData;
    // print(offlineData);
    notifyListeners();
  }

  getOnline({bool? isRefresh = false, String? value}) async {
    if (isRefresh == false && offlineData.isNotEmpty) return;
    var response = await AppProviders.appProvider
        .httpGet(url: "${BaseUrl.taxations}${value ?? ''}");
    List data = [];
    // print(response.body);
    if (response.statusCode == 200) {
      data = jsonDecode(response.body)['data'];
    } else {
      return;
    }
    dataList = List<TaxationModel>.from(
        data.map((item) => TaxationModel.fromJSON(item)).toList());
    SyncOnlineLocalHelper.insertNewDataOffline(
        onlineData: dataList.map((e) => e.toJSON()).toList(),
        offlineData: offlineData.map((e) => e.toJSON()).toList(),
        key: keyName,
        callback: () {
          getOffline(isRefresh: true);
        });
    notifyListeners();
  }

  reset() {
    offlineData.clear();
    dataList.clear();

    notifyListeners();
  }

  List<TaxationModel> dataToSync = [];
  syncOfflineData() async {
    if (dataToSync.isEmpty) return;
    Response response = await AppProviders.appProvider.httpPost(
        url: "${BaseUrl.taxations}sync",
        body: {"data": dataToSync.map((e) => e.toJSON()).toList()});
    // print(response.body);
    if (response.statusCode == 200) {
      ToastNotification.showToast(
          msg: "Synchronisation des données terminés",
          msgType: MessageType.info,
          title: "Information");
      LocalDataHelper.clearLocalData(key: keyName);
      getOnline(isRefresh: true);
      return;
    }
    ToastNotification.showToast(
        msg: jsonDecode(response.body)['message'] ??
            "Une erreur est survenue lors de la synchronisation des données",
        msgType: MessageType.error,
        title: "Erreur");
  }

  List<TaxationModel> getDataToSync() {
    getOffline(isRefresh: true);
    dataToSync =
        offlineData.where((element) => element.syncStatus != 1).toList();
    // print(dataToSync.map((e) => e.toJSON()).toList());
    return dataToSync;
  }
}
