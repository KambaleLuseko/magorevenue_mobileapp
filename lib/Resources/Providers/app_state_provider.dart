import 'dart:async';
import 'dart:convert';
import 'dart:io';
import '../../Resources/Constants/app_providers.dart';
import '../../Resources/Constants/enums.dart';
import '../../Resources/Constants/global_variables.dart';
import '../../main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AppStateProvider extends ChangeNotifier {
  bool isAsync = false, isApiReachable = true, needToWorkOffline = false;
  changeAppState() async {
    isAsync = !isAsync;
    notifyListeners();
  }

  checkApiConnectivity() async {
    await httpGet(url: BaseUrl.ip).then((response) {
      if (response.statusCode == 200) {
        isApiReachable = true;
        needToWorkOffline = false;
      } else {
        isApiReachable = false;
        ToastNotification.showToast(
            msg:
                "Vous êtes actuellement en mode hors connexion.\nSi vous voulez basculer de mode, cliquez sur l'icone de connection dans le menu gauche",
            msgType: MessageType.info,
            title: "Information");
        // Dialogs.showDialogWithAction(
        //     title: "Confirmation",
        //     content:
        //         "Voulez-vous continuer de travailler hors connection? Si vous voulez basculer de mode, cliquez sur l'icone de connection dans le menu gauche",
        //     callback: () {
        //       needToWorkOffline = true;
        //     });
      }
    });
    notifyListeners();
  }

  int timeOut = 30;

  Future<Response> httpPost({required String url, required Map body}) async {
    // debugPrint("post $body");
    try {
      // print('changing state');
      changeAppState();
      Response response = await http
          .post(Uri.parse(url), body: jsonEncode(body), headers: headers)
          .timeout(Duration(seconds: timeOut));
      isApiReachable = true;
      // print("post" + response.body + "post");
      changeAppState();
      // print('changing state');
      return response;
    } on TimeoutException {
      isApiReachable = false;
      changeAppState();
      return Response(
          jsonEncode({
            'data': [],
            'message':
                "Echec de connexion, veuillez réessayer. Sauvegarde hors connexion"
          }),
          500);
    } on SocketException {
      isApiReachable = false;
      changeAppState();
      return Response(
          jsonEncode({
            'data': [],
            'message': "Echec de connexion, sauvegarde hors connexion"
          }),
          500);
    } catch (error) {
      // print(error.toString());
      isApiReachable = false;
      changeAppState();
      return Response(
          jsonEncode(
              {'data': [], 'message': "Erreur inattendue, sauvegarde offline"}),
          500);
    }
  }

  Future<Response> httpPut({required String url, required Map body}) async {
    // print("put $url");
    try {
      changeAppState();
      Response response = await http
          .put(Uri.parse(url), body: jsonEncode(body), headers: headers)
          .timeout(Duration(seconds: timeOut));
      isApiReachable = true;
      changeAppState();
      return response;
    } on TimeoutException {
      isApiReachable = false;
      changeAppState();
      return Response(
          jsonEncode({
            'data': [],
            'message': "Echec de connexion, veuillez réessayer"
          }),
          500);
    } on SocketException {
      isApiReachable = false;
      changeAppState();
      return Response(
          jsonEncode({'data': [], 'message': "Verifiez votre connexion"}), 500);
    } catch (error) {
      isApiReachable = false;
      // print(error.toString());
      changeAppState();
      return Response(
          jsonEncode({
            'data': [],
            'message': "Une erreur est survenue, veuillez réessayer"
          }),
          500);
    }
  }

  Future<Response> httpDelete({required String url}) async {
    // print("delete $url");
    changeAppState();
    try {
      Response response = await http
          .delete(Uri.parse(url), headers: headers)
          .timeout(Duration(seconds: timeOut));
      // print(response.body);
      isApiReachable = true;
      changeAppState();
      return response;
    } on TimeoutException {
      isApiReachable = false;
      changeAppState();
      return Response(
          jsonEncode({
            'data': [],
            'message': "Echec de connexion, veuillez réessayer"
          }),
          500);
    } on SocketException {
      isApiReachable = false;
      changeAppState();
      return Response(
          jsonEncode({'data': [], 'message': "Verifiez votre connexion"}), 500);
    } catch (error) {
      isApiReachable = false;
      // print(error.toString());
      changeAppState();
      return Response(
          jsonEncode({
            'data': [],
            'message': "Une erreur est survenue, veuillez réessayer"
          }),
          500);
    }
  }

  Future<Response> httpGet({required String url}) async {
    // if (navKey.currentContext!.read<AppStateProvider>().isAsync == true) return;
    // print("get $url");
    changeAppState();
    try {
      final response = await http
          .get(
            Uri.parse(url),
            headers: headers,
          )
          .timeout(Duration(seconds: timeOut));
      isApiReachable = true;
      changeAppState();
      // print(response.body);
      return response;
    } on TimeoutException {
      isApiReachable = false;
      changeAppState();
      return Response(
          jsonEncode({
            'data': [],
            'message': "Echec de connexion, veuillez réessayer"
          }),
          500);
    } on SocketException {
      isApiReachable = false;
      changeAppState();
      return Response(
          jsonEncode({'data': [], 'message': "Verifiez votre connexion"}), 500);
    } catch (error) {
      isApiReachable = false;
      // print(error.toString());
      changeAppState();
      return Response(
          jsonEncode({
            'data': [],
            'message': "Une erreur est survenue, veuillez réessayer"
          }),
          500);
    }
  }

  Future<bool> syncData() async {
    try {
      // await AppProviders.partnerProvider.syncOfflineData();
      // await AppProviders.analyseToolsProvider.syncOfflineData();
      // await AppProviders.analysesProvider.syncOfflineData();
      // await AppProviders.storesProvider.syncOfflineData();
      // await AppProviders.usersProvider.syncOfflineData();
      // await AppProviders.walletProvider.syncOfflineData();
      // await AppProviders.currencyProvider.syncOfflineData();
      // await AppProviders.sampleProvider.syncOfflineData();
      // await navKey.currentContext!
      //     .read<TransactionProvider>()
      //     .syncOfflineData();
      // await AppProviders.paymentProvider.syncOfflineData();
      // print('sync finished');
      return true;
    } on TimeoutException {
      isApiReachable = false;
      changeAppState();
      return false;
    } on SocketException {
      isApiReachable = false;
      changeAppState();
      return false;
    } catch (error) {
      isApiReachable = false;
      changeAppState();
      return false;
    }
  }

  Map stats = {
    "countTools": 0,
    "countAnalyses": 0,
    "countPartners": 0,
    "countStores": 0,
    "countCurrencies": 0,
    "countWallets": 0
  };
  getStats() async {
    await httpGet(url: BaseUrl.stats).then((response) {
      if (response.statusCode == 200) {
        // print(response.body);
        stats = (jsonDecode(response.body)['data']);
        notifyListeners();
      }
    }).catchError((err) {
      // print(err.toString());
    });
  }

  // List<ColissageModel> weeklyData = [];
  List<Map> weeks = [];
  double sumSell = 0, sumBuy = 0;
  static String startDate =
      DateTime.now().subtract(const Duration(days: 7)).toString().split(' ')[0];
  List dates = getDaysInBetween(DateTime.parse(startDate), DateTime.now())
      .map((e) => {"date": e, 'amountSell': 0, 'amountBuy': 0})
      .toList();
  getWeeklyTransactions({bool? isRefresh = false}) async {
    if (dates.isEmpty) {
      dates = getDaysInBetween(DateTime.parse(startDate), DateTime.now())
          .map((e) => {"date": e, 'amountSell': 0, 'amountBuy': 0})
          .toList();
    }
    notifyListeners();
    // if (AppProviders.appProvider.isAsync == true) return;
    await httpGet(url: "${BaseUrl.stats}week/$startDate").then((response) {
      if (isRefresh == false && (sumSell > 0 || sumBuy > 0)) return;
      // print('weekly stats called');
      if (response.statusCode == 200) {
        sumSell = 0;
        sumBuy = 0;
        // print(response.body);
        List data = jsonDecode(response.body)['data'];
        dates = getDaysInBetween(DateTime.parse(startDate), DateTime.now())
            .map((e) => {"date": e, 'amountSell': 0, 'amountBuy': 0})
            .toList();
        for (int iData = 0; iData < data.length; iData++) {
          String pattern = ' ';
          List content = jsonDecode(data[iData]['content']);
          for (int jContent = 0; jContent < content.length; jContent++) {
            if (data[iData]['transactionType'].toString().toLowerCase() ==
                'vente') {
              sumSell += double.parse(content[jContent]['value'].toString());
            }
            if (data[iData]['transactionType'].toString().toLowerCase() ==
                    'achat' ||
                data[iData]['transactionType'].toString().toLowerCase() ==
                    'expense') {
              sumBuy += double.parse(content[jContent]['value'].toString());
            }
            for (int kDates = 0; kDates < dates.length; kDates++) {
              if (data[iData]['transactionType'].toString().toLowerCase() ==
                  'vente') {
                if (dates[kDates]['date'].toString().split(' ')[0].trim() ==
                    DateTime.parse(data[iData]['createdAt'])
                        .toString()
                        .split(pattern)[0]
                        .trim()) {
                  dates[kDates]['amountSell'] =
                      double.parse(dates[kDates]['amountSell'].toString()) +
                          double.parse(content[jContent]['value'].toString());
                }
              }
              if (data[iData]['transactionType'].toString().toLowerCase() ==
                      'achat' ||
                  data[iData]['transactionType'].toString().toLowerCase() ==
                      'expense') {
                if (dates[kDates]['date'].toString().split(' ')[0].trim() ==
                    DateTime.parse(data[iData]['createdAt'])
                        .toString()
                        .split(pattern)[0]
                        .trim()) {
                  dates[kDates]['amountBuy'] =
                      double.parse(dates[kDates]['amountBuy'].toString()) +
                          double.parse(content[jContent]['value'].toString());
                }
              }
            }
          }
        }
        notifyListeners();
      }
    }).catchError((err) {
      // print(err.toString());
    });
  }

  reset() {
    sumBuy = 0;
    sumSell = 0;
    dates.clear();
    weeks.clear();
    // weeklyData.clear();
  }

  static List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(DateTime.parse(startDate
          .add(Duration(days: i))
          .toString()
          .split(' ')[0]
          .toString()));
    }
    return days;
  }
}
