import 'package:flutter/material.dart';

class MenuModel {
  String title;
  Widget page;
  IconData? icon;
  MenuModel({required this.title, required this.page, this.icon});

  static fromJSON(json) {
    return MenuModel(
        title: json['title'], page: json['page'], icon: json['icon']);
  }
}
