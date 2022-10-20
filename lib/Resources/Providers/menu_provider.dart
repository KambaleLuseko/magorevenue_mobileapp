import 'package:tax_payment_app/Views/Clients/client.page.dart';
import 'package:tax_payment_app/Views/Divisions/division.page.dart';
import 'package:tax_payment_app/Views/Sync/sync.page.dart';
import 'package:tax_payment_app/Views/Taxes/tax.page.dart';

import '../../Views/Home/home.page.dart';

import '../../Resources/Models/Menu/menu.model.dart';
import 'package:flutter/material.dart';

class MenuProvider extends ChangeNotifier {
  List menus = [
    MenuModel(title: "Accueil", page: const HomePage(), icon: Icons.home),
    MenuModel(title: "Assujetis", page: const ClientPage(), icon: Icons.person),
    MenuModel(title: "Taxes", page: const TaxPage(), icon: Icons.payment),
    MenuModel(title: "Sync", page: const SyncDataPage(), icon: Icons.sync),
  ];

  MenuModel activePage = MenuModel(
      title: "Accueil", page: const DivisionPage(), icon: Icons.person);
  reset() {
    activePage = MenuModel(
        title: "Accueil", page: const DivisionPage(), icon: Icons.person);
    menus.clear();
  }

  getActivePage() => activePage;

  setActivePage({required MenuModel newPage}) {
    activePage = newPage;
    notifyListeners();
  }
}
