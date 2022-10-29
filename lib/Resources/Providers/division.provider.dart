import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tax_payment_app/Resources/Constants/app_providers.dart';
import 'package:tax_payment_app/Resources/Constants/global_variables.dart';
import 'package:tax_payment_app/Resources/Helpers/LocalData/local_data.helper.dart';
import 'package:tax_payment_app/Resources/Helpers/sync_online_local.dart';
import 'package:tax_payment_app/Resources/Models/division.model.dart';
import 'package:collection/collection.dart';

class DivisionProvider extends ChangeNotifier {
  String keyName = 'divisions';
  List<DivisionModel> dataList = [], offlineData = [];

  DivisionModel? currentDivision;

  setDivision(DivisionModel division) {
    currentDivision = division;
    notifyListeners();
  }

  updateCurrentDivision() {
    currentDivision =
        offlineData.firstWhereOrNull((item) => item.id == currentDivision?.id);
    notifyListeners();
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
    offlineData = List<DivisionModel>.from(
        data.map((item) => DivisionModel.fromJSON(item)).toList());
    updateCurrentDivision();
    notifyListeners();
  }

  getOnline({bool? isRefresh = false, String? value}) async {
    if (isRefresh == false && offlineData.isNotEmpty) return;
    var response = await AppProviders.appProvider
        .httpGet(url: "${BaseUrl.divisions}${value ?? ''}");
    List data = [];
    // debugPrint(response.body);
    if (response.statusCode == 200) {
      data = jsonDecode(response.body)['data'];
    } else {
      return;
    }
    dataList = List<DivisionModel>.from(
        data.map((item) => DivisionModel.fromJSON(item)).toList());
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
    currentDivision = null;
    dataList.clear();
    notifyListeners();
  }
}
